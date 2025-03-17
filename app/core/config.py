from pydantic_settings import BaseSettings

class Settings(BaseSettings):
    PROJECT_NAME: str = "User Management API"
    PROJECT_VERSION: str = "1.0.0"
    DATABASE_URL: str = "sqlite:///./test.db"

    class Config:
        env_file = ".env"

settings = Settings()
