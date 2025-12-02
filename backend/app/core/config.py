"""Application configuration using Pydantic Settings"""
from typing import List
from pydantic import AnyHttpUrl, validator
from pydantic_settings import BaseSettings


class Settings(BaseSettings):
    """Application settings"""
    
    # App
    APP_NAME: str = "Memoir"
    DEBUG: bool = False
    SECRET_KEY: str
    ENVIRONMENT: str = "production"
    API_V1_PREFIX: str = "/api/v1"
    
    # Database
    DATABASE_URL: str
    DATABASE_URL_SYNC: str
    
    # Redis
    REDIS_URL: str
    
    # OpenAI
    OPENAI_API_KEY: str
    OPENAI_MODEL_CLASSIFICATION: str = "gpt-4o-mini"
    OPENAI_MODEL_EMBEDDING: str = "text-embedding-3-small"
    
    # Auth
    JWT_SECRET_KEY: str
    JWT_ALGORITHM: str = "HS256"
    ACCESS_TOKEN_EXPIRE_MINUTES: int = 30
    REFRESH_TOKEN_EXPIRE_DAYS: int = 7
    
    # Celery
    CELERY_BROKER_URL: str
    CELERY_RESULT_BACKEND: str
    
    # CORS
    CORS_ORIGINS: str = "http://localhost:3000,http://localhost:8080"
    
    def get_cors_origins(self) -> List[str]:
        """Get CORS origins as a list"""
        if isinstance(self.CORS_ORIGINS, str):
            return [i.strip() for i in self.CORS_ORIGINS.split(",")]
        return []
    
    class Config:
        env_file = ".env"
        case_sensitive = True


settings = Settings()

