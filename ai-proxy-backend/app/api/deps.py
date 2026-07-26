from sqlalchemy.orm import Session

from app.services.learning_service import LearningService


def create_learning_service(
    db: Session,
) -> LearningService:

    return LearningService(db)