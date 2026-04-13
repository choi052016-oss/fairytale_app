from fastapi import FastAPI, HTTPException
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel
from typing import Optional
from database import users_collection
from models import UserSchema

app = FastAPI(title="동화 생성 앱 백엔드", description="FastAPI 및 MongoDB 연동")

# CORS 설정 (플러터 웹/앱 통신 허용)
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"], 
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# ----------------------------------------------------
# 데이터 스키마 (추가 정보 업데이트용)
# ----------------------------------------------------
class UserUpdateSchema(BaseModel):
    phone: Optional[str] = None
    address: Optional[str] = None

# ----------------------------------------------------
# API 라우터
# ----------------------------------------------------
@app.get("/")
async def root():
    return {"message": "동화 생성 API 서버가 정상적으로 실행 중입니다!"}


@app.post("/api/users/register", response_description="신규 회원가입")
async def register_user(user: UserSchema):
    # Pydantic 모델을 딕셔너리로 변환
    user_dict = user.model_dump() 
    
    # MongoDB에 데이터 삽입
    result = await users_collection.insert_one(user_dict)
    
    if result.inserted_id:
        return {
            "message": f"{user.nickname}님, 회원가입이 성공적으로 완료되었습니다!", 
            "account_id": user.account_id
        }
    
    raise HTTPException(status_code=500, detail="회원가입 데이터베이스 저장에 실패했습니다.")


@app.put("/api/users/{account_id}/profile", response_description="유저 추가 정보 업데이트")
async def update_user_profile(account_id: str, update_data: UserUpdateSchema):
    # 입력된 값만 딕셔너리로 변환 (None 값 제외)
    update_dict = {k: v for k, v in update_data.model_dump().items() if v is not None}
    
    if not update_dict:
        return {"message": "업데이트할 정보가 없습니다."}

    # MongoDB에서 업데이트
    result = await users_collection.update_one(
        {"account_id": account_id}, 
        {"$set": update_dict}
    )

    if result.modified_count == 1:
        return {"message": "추가 정보가 성공적으로 저장되었습니다!"}
    
    return {"message": "저장된 내역이 없거나 이미 최신 상태입니다."}