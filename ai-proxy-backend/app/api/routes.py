from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session

from app.db.database import get_db

from app.schemas.requests import (
    AssessmentRequest,
    LearningGoalRequest,
    LessonSessionRequest,
    TechniqueRequest,
)
from app.schemas.responses import (
    LessonSessionResponse,
    SyllabusResponse,
)

from app.services.learning_service import LearningService


router = APIRouter(
    prefix="/learning",
    tags=["Learning"],
)



def service(
    db: Session = Depends(get_db),
):
    return LearningService(db)



# ======================================================
# Generate syllabus
# ======================================================


@router.post("/generateSyllabusFromGoal", response_model=SyllabusResponse)
async def generate_syllabus(
    request: LearningGoalRequest,
    taxonomy_id: int = 1,
    learning_service: LearningService = Depends(service),
):
    try:
        return await (
            learning_service
            .generate_syllabus_from_goal(
                request,
                taxonomy_id,
            )
        )

    except ValueError as error:
        raise HTTPException(
            status_code=404,
            detail=str(error),
        )



# ======================================================
# Generate lesson session
# ======================================================


@router.post("/generateLessonSession", response_model=LessonSessionResponse)
async def generate_lesson_session(
    request: LessonSessionRequest,
    learning_service: LearningService = Depends(service),
):

    try:

        return await (
            learning_service
            .generate_lesson_session(
                request,
            )
        )


    except ValueError as error:

        raise HTTPException(
            status_code=404,
            detail=str(error),
        )



# ======================================================
# Generate technique addon
# ======================================================


@router.post("/generateTechniqueItem")
async def generate_technique(
    request: TechniqueRequest,
    learning_service: LearningService = Depends(service),
):

    try:

        return await (
            learning_service
            .generate_technique_item(
                request
            )
        )


    except ValueError as error:

        raise HTTPException(
            status_code=404,
            detail=str(error),
        )



# ======================================================
# Generate assessment addon
# ======================================================


@router.post("/generateAssessmentItem")
async def generate_assessment(
    request: AssessmentRequest,
    learning_service: LearningService = Depends(service),
):

    try:

        return await (
            learning_service
            .generate_assessment_item(
                request
            )
        )


    except ValueError as error:

        raise HTTPException(
            status_code=404,
            detail=str(error),
        )