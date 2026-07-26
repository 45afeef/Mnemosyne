from functools import lru_cache

from pydantic_settings import BaseSettings, SettingsConfigDict


class Settings(BaseSettings):
    model_config = SettingsConfigDict(
        env_file=".env",
        case_sensitive=False,
        extra="ignore",
    )

    # ---------- App ----------
    APP_NAME: str = "Learning AI Proxy"
    DEBUG: bool = False

    # ---------- AI ----------
    AI_API_KEY: str
    MODEL: str = "gpt-5"

    # ---------- Database ----------
    DATABASE_URL: str


@lru_cache
def get_settings() -> Settings:
    return Settings()


settings = get_settings()