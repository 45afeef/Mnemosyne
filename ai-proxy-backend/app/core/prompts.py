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

Your task is to generate a syllabus tree from a user's learning goal.

The curriculum structure is controlled by the predefined taxonomy and stages.
You must NOT invent new stages or new hierarchy types.

Use the provided structure and generate meaningful subjects, modules, and learning items.

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
- Use only the keys: "subjects", "name", "description", "modules", "learning_items", "content".
- Do not include any extra fields.
- Return valid JSON only.

JSON format:

{{
    "subjects": [
        {{
            "name": "",
            "description": "",
            "modules": [
                {{
                    "name": "",
                    "description": "",
                    "learning_items": [
                        {{
                            "name": "",
                            "description": "",
                            "content": "",
                            "learning_items": []
                        }}
                    ]
                }}
            ]
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


Source Learning Items:

{learning_items}


Allowed Techniques:

{techniques}


Allowed Assessments:

{assessments}


Rules:

1. Use the provided leaf learning items as the lesson source.
2. Output a JSON object with a single key: "learning_items".
3. Each item must be a learning item with only the fields: "name", "description", "content", and optional nested "learning_items" when needed.
4. Do not include any extra fields.
5. Make explanations clear and beginner friendly.
6. Return JSON only.


Output:

{{
    "learning_items": [
        {{
            "name": "",
            "description": "",
            "content": ""
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