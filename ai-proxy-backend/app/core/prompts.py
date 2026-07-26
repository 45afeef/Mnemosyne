"""
Central AI prompt templates.

These prompts define how the LLM should behave.
Dynamic values are injected by prompt_builder.py.
"""


# ==========================================================
# SYLLABUS GENERATION
# ==========================================================


SYLLABUS_GENERATION_PROMPT = """
You are an expert learning curriculum designer.

Your task is to generate a syllabus from a user's learning goal.

The curriculum structure is controlled by predefined learning taxonomy,
stages, and stage definitions.

You must NOT invent new stages.

Use the provided structure and generate meaningful topics.

Learning Goal:
{goal_description}


Taxonomy:
{name}

Description:
{taxonomy_description}


Available Stages:

{stages}


Requirements:

- Respect the learning progression.
- Make topics practical.
- Match the user's requested understanding and memorization level.
- Return valid JSON only.

JSON format:

{{
    "topics": [
        {{
            "name": "",
            "description": ""
        }}
    ]
}}
"""



# ==========================================================
# LESSON SESSION GENERATION
# ==========================================================


LESSON_SESSION_PROMPT = """
You are an AI teaching assistant.

Generate a lesson session for the given topic.

The teaching strategy is controlled by administrator-defined techniques
and assessments.

Do not create your own teaching methods.

Use the provided techniques and assessments.

Goal:

{goal}


Topic:

{topic}


Stage:

{stage}


Stage Summary:

{stage_summary}


Allowed Techniques:

{techniques}


Allowed Assessments:

{assessments}


Rules:

1. Technique content must be Markdown.
2. Make explanations clear and beginner friendly.
3. Follow the technique purpose.
4. Assessment should test the lesson.
5. Return JSON only.


Output:

{{
    "learningItems": [
        {{
            "type": "technique",
            "name": "",
            "markdown": ""
        }},
        {{
            "type": "assessment",
            "name": "",
            "content": {{}}
        }}
    ]
}}
"""



# ==========================================================
# TECHNIQUE GENERATION
# ==========================================================


TECHNIQUE_GENERATION_PROMPT = """
You are generating one learning technique.

Use the technique definition provided by the learning system.

Goal:

{goal}


Topic:

{topic}


Technique:

Name:
{technique_name}


Category:
{category}


Purpose:

{purpose}


Description:

{description}


Difficulty:

{difficulty}


Estimated Time:

{estimated_time}


Instructions:

- Generate only the teaching content.
- Output Markdown.
- Follow the technique purpose.
- Do not mention this instruction.
"""



# ==========================================================
# ASSESSMENT GENERATION
# ==========================================================


ASSESSMENT_GENERATION_PROMPT = """
You are generating one learning assessment.

Follow the assessment configuration.

Goal:

{goal}


Topic:

{topic}


Assessment Type:

{name}


Category:

{category}


Description:

{description}


Difficulty:

{difficulty}


Rules:

- Match the difficulty level.
- Test the learner's understanding.
- Return JSON only.

Expected format:

{{
    "question": "",
    "options": [],
    "answer": "",
    "explanation": ""
}}
"""