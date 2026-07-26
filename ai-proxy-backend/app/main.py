from fastapi import FastAPI

from .ai import ask_ai
from .models import (
    AssessmentRequest,
    LearningGoalRequest,
    LessonSessionRequest,
    TechniqueRequest,
)
from .prompts import (
    ASSESSMENT_PROMPT,
    GOAL_PROMPT,
    LESSON_PROMPT,
    TECHNIQUE_PROMPT,
)

app = FastAPI(title="Learning AI Proxy")


@app.post("/generateSyllabusFromGoal")
def generate_syllabus(req: LearningGoalRequest):
    result = ask_ai(
        GOAL_PROMPT,
        req.model_dump_json(indent=2),
    )

    return {
        "result": result
    }


@app.post("/generateLessonSession")
def generate_lesson(req: LessonSessionRequest):
    result = ask_ai(
        LESSON_PROMPT,
        req.model_dump_json(indent=2),
    )

    return {
        "result": result
    }


@app.post("/generateTechniqueItem")
def generate_technique(req: TechniqueRequest):
    prompt = TECHNIQUE_PROMPT.format(
        technique=req.technique,
        previous=req.previous_items,
    )

    result = ask_ai(
        prompt,
        req.model_dump_json(indent=2),
    )

    return {
        "result": result
    }


@app.post("/generateAssessmentItem")
def generate_assessment(req: AssessmentRequest):
    prompt = ASSESSMENT_PROMPT.format(
        assessment=req.assessment,
        previous=req.previous_items,
    )

    result = ask_ai(
        prompt,
        req.model_dump_json(indent=2),
    )

    return {
        "result": result
    }