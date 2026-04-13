from motor.motor_asyncio import AsyncIOMotorClient


MONGO_DETAILS = "mongodb+srv://admin:1234@cluster0.ynsi1d2.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0"

client = AsyncIOMotorClient(MONGO_DETAILS)


database = client.fairytale_db

# 핵심 컬렉션 연결 
users_collection = database.get_collection("users")
stories_collection = database.get_collection("stories")
vocabularies_collection = database.get_collection("vocabularies")