from fastapi import FastAPI

from app.api.routes import router
from app.db.init import initialize_database


app = FastAPI(
    title="Learning AI Proxy",
    version="1.0.0",
)


app.include_router(router)


@app.on_event("startup")
def startup():

    initialize_database()



@app.get("/health")
def health_check():

    return {
        "status": "ok"
    }