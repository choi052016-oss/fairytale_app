from pydantic import BaseModel, Field
from typing import Optional, Dict
from datetime import datetime

class UserSchema(BaseModel):
    account_id: str # 이메일이나 소셜 고유 ID를 넣습니다.
    password: Optional[str] = None # 소셜 로그인은 비밀번호가 없으므로 Optional로 변경
    nickname: str
    email: Optional[str] = None
    provider: str = "local" # 'local'(일반가입), 'kakao', 'google', 'naver' 등 구분
    provider_id: Optional[str] = None # 카카오, 구글 등에서 넘겨주는 유저 고유 번호
    phone: Optional[str] = None
    address: Optional[str] = None
    personality_type: Optional[str] = "분석 전"
    radar_stats: Optional[Dict] = {}
    created_at: datetime = Field(default_factory=datetime.utcnow)

