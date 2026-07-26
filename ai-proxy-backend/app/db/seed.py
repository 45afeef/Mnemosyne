from typing import Dict

from sqlalchemy.orm import Session

from app.db.models import (
    Assessment,
    AssessmentCategory,
    Stage,
    StageDefinition,
    StageTechnique,
    Technique,
    TechniqueAssessment,
    TechniqueCategory,
    Taxonomy,
)


TECHNIQUES = [
    ("Analogy", TechniqueCategory.UNDERSTAND),
    ("Example", TechniqueCategory.UNDERSTAND),
    ("Simile", TechniqueCategory.UNDERSTAND),
    ("Real World Example", TechniqueCategory.UNDERSTAND),
    ("Comparison", TechniqueCategory.UNDERSTAND),
    ("Narrative", TechniqueCategory.UNDERSTAND),
    ("Metaphor", TechniqueCategory.UNDERSTAND),
    ("Step By Step", TechniqueCategory.PRACTICE),
    ("Chunking", TechniqueCategory.MEMORIZATION),
    ("Method of Loci", TechniqueCategory.MEMORIZATION),
    ("Memory Palace", TechniqueCategory.MEMORIZATION),
    ("Song", TechniqueCategory.MEMORIZATION),
    ("Rhyme", TechniqueCategory.MEMORIZATION),
    ("Mnemonics", TechniqueCategory.MEMORIZATION),
    ("Peg System", TechniqueCategory.MEMORIZATION),
    ("PAO System", TechniqueCategory.MEMORIZATION),
    ("Acronyms", TechniqueCategory.MEMORIZATION),
    ("Association", TechniqueCategory.MEMORIZATION),
    ("Acrostic", TechniqueCategory.MEMORIZATION),
]


ASSESSMENTS = [
    ("Multiple Choice Question", AssessmentCategory.RECOGNITION),
    ("Fill In The Blank", AssessmentCategory.RECALL),
    ("True Or False", AssessmentCategory.RECOGNITION),
    ("Flash Card", AssessmentCategory.RECALL),
    ("Essay", AssessmentCategory.APPLICATION),
    ("One Word Answer", AssessmentCategory.RECALL),
    ("Application",AssessmentCategory.APPLICATION),
]


BLOOMS_STAGES = [
    (
        "Memorize",
        "Help learners retain core facts, terms, and definitions through repetition and memory aids.",
        1,
    ),
    (
        "Understand",
        "Guide learners to explain ideas, summarize concepts, and interpret meaning.",
        2,
    ),
    (
        "Practice",
        "Encourage learners to rehearse and apply knowledge in guided exercises.",
        3,
    ),
    (
        "Apply",
        "Let learners use knowledge in practical situations and real workflows.",
        4,
    ),
    (
        "Analyze",
        "Develop the ability to break down information, compare ideas, and identify patterns.",
        5,
    ),
    (
        "Evaluate",
        "Help learners judge quality, justify choices, and assess outcomes.",
        6,
    ),
    (
        "Create",
        "Support learners in generating original work, solutions, and new connections.",
        7,
    ),
]


STAGE_DEFINITIONS = {
    "Memorize": "Memorize uses mnemonic systems, repetition, and auditory cues to make facts stick.",
    "Understand": "Understand connects ideas through analogies, examples, and simple explanations.",
    "Practice": "Practice reinforces learning through guided steps and repeated exercises.",
    "Apply": "Apply uses real-world scenarios so learners transfer knowledge into action.",
    "Analyze": "Analyze compares concepts and highlights structure, themes, and relationships.",
    "Evaluate": "Evaluate uses thoughtful reflection and judgment-based assessments.",
    "Create": "Create invites learners to craft original responses and design new solutions.",
}


STAGE_TECHNIQUES = {
    "Memorize": [
        "Chunking",
        "Method of Loci",
        "Memory Palace",
        "Song",
        "Rhyme",
        "Mnemonics",
        "Peg System",
        "PAO System",
        "Acronyms",
        "Association",
        "Acrostic",
    ],
    "Understand": [
        "Analogy",
        "Example",
        "Simile",
        "Real World Example",
        "Comparison",
        "Narrative",
        "Metaphor",
    ],
    "Practice": [
        "Step By Step",
        "Example",
        "Chunking",
        "Comparison",
    ],
    "Apply": [
        "Step By Step",
        "Real World Example",
        "Example",
        "Analogy",
    ],
    "Analyze": [
        "Comparison",
        "Chunking",
        "Narrative",
        "Metaphor",
    ],
    "Evaluate": [
        "Example",
        "Comparison",
        "Narrative",
        "Analogy",
    ],
    "Create": [
        "Real World Example",
        "Narrative",
        "Metaphor",
        "Example",
    ],
}


TECHNIQUE_ASSESSMENTS = {
    "Chunking": ["Multiple Choice Question", "Fill In The Blank", "Flash Card"],
    "Method of Loci": ["Flash Card", "One Word Answer"],
    "Memory Palace": ["Flash Card", "One Word Answer"],
    "Mnemonics": ["Multiple Choice Question", "Fill In The Blank"],
    "Acronyms": ["Multiple Choice Question", "True Or False"],
    "Analogy": ["Multiple Choice Question", "Essay"],
    "Example": ["True Or False", "Multiple Choice Question"],
    "Simile": ["Fill In The Blank", "Multiple Choice Question"],
    "Real World Example": ["Essay", "Application"],
    "Comparison": ["Essay", "Multiple Choice Question"],
    "Narrative": ["Essay", "True Or False"],
    "Metaphor": ["Fill In The Blank", "Essay"],
    "Step By Step": ["Fill In The Blank", "One Word Answer"],
}


def _get_or_create_techniques(db: Session) -> Dict[str, Technique]:
    techniques_by_name: Dict[str, Technique] = {}

    for name, category in TECHNIQUES:
        technique = (
            db.query(Technique)
            .filter(Technique.name == name)
            .first()
        )

        if not technique:
            technique = Technique(
                name=name,
                category=category,
                description=f"{name} based learning technique",
                purpose=f"Improve learning using {name}",
                difficulty=1,
                estimated_time=5,
                supports_ai=True,
            )
            db.add(technique)

        techniques_by_name[name] = technique

    return techniques_by_name


def _get_or_create_assessments(db: Session) -> Dict[str, Assessment]:
    assessments_by_name: Dict[str, Assessment] = {}

    for name, category in ASSESSMENTS:
        assessment = (
            db.query(Assessment)
            .filter(Assessment.name == name)
            .first()
        )

        if not assessment:
            assessment = Assessment(
                name=name,
                category=category,
                description=f"{name} assessment method",
                difficulty=1,
                supports_ai=True,
            )
            db.add(assessment)

        assessments_by_name[name] = assessment

    return assessments_by_name


def _get_or_create_taxonomy(db: Session) -> Taxonomy:
    taxonomy = (
        db.query(Taxonomy)
        .filter(Taxonomy.name == "Bloom's Taxonomy")
        .first()
    )

    if not taxonomy:
        taxonomy = Taxonomy(
            name="Bloom's Taxonomy",
            description="A revised educational framework for organizing learning objectives from simple recall to creative production.",
        )
        db.add(taxonomy)

    return taxonomy


def seed_database(db: Session):
    techniques_by_name = _get_or_create_techniques(db)
    assessments_by_name = _get_or_create_assessments(db)

    db.flush()

    taxonomy = _get_or_create_taxonomy(db)
    db.flush()

    for stage_name, description, order in BLOOMS_STAGES:
        stage = (
            db.query(Stage)
            .filter(Stage.taxonomy_id == taxonomy.id, Stage.name == stage_name)
            .first()
        )

        if not stage:
            stage = Stage(
                taxonomy_id=taxonomy.id,
                name=stage_name,
                order=order,
                description=description,
            )
            db.add(stage)
            db.flush()

        definition = (
            db.query(StageDefinition)
            .filter(StageDefinition.stage_id == stage.id)
            .first()
        )

        if not definition:
            definition = StageDefinition(
                stage_id=stage.id,
                summary=STAGE_DEFINITIONS[stage_name],
            )
            db.add(definition)
            db.flush()

        for technique_name in STAGE_TECHNIQUES.get(stage_name, []):
            technique = techniques_by_name[technique_name]
            exists = (
                db.query(StageTechnique)
                .filter(
                    StageTechnique.stage_definition_id == definition.id,
                    StageTechnique.technique_id == technique.id,
                )
                .first()
            )

            if not exists:
                db.add(
                    StageTechnique(
                        stage_definition_id=definition.id,
                        technique_id=technique.id,
                        weight=1.0,
                    )
                )

    for technique_name, assessment_names in TECHNIQUE_ASSESSMENTS.items():
        technique = techniques_by_name[technique_name]

        for assessment_name in assessment_names:
            assessment = assessments_by_name[assessment_name]
            exists = (
                db.query(TechniqueAssessment)
                .filter(
                    TechniqueAssessment.technique_id == technique.id,
                    TechniqueAssessment.assessment_id == assessment.id,
                )
                .first()
            )

            if not exists:
                db.add(
                    TechniqueAssessment(
                        technique_id=technique.id,
                        assessment_id=assessment.id,
                        weight=1.0,
                    )
                )

    db.commit()