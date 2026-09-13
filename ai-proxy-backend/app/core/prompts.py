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
{goal_name}
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
    "title": "",
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
You are an AI teaching assistant designing a low-cognitive-load lesson session.

Generate a lesson session for the given topic.

Use the goal and the source learning items to choose the most suitable techniques and assessments.
Do not invent new teaching methods.

Goal:

{goal}


Topic:

{topic}


Source Learning Items:

{learning_items}


Technique Pool:

{techniques}


Assessment Pool:

{assessments}


Rules:

1. Use the provided source learning items as the lesson foundation.
2. Choose the best techniques for the goal and topic, not just generic ones.
3. Create a short ordered sequence of lesson items with gradually increasing difficulty.
4. Keep cognitive load low by starting with simple concepts and slowly building complexity.
5. Each lesson item should be small to medium in length and should teach one focused idea.
6. Each lesson item must contain:
   - a "name"
   - an optional "description"
   - a "techniques" array with minimum of 3 technique blocks, increase the count based on concept difficulty, select the technique from the pool
   - a "assessment" array with selected from the pool
7. Each technique block must be Markdown and should explain one small idea clearly.
8. Each assessment should be a JSON object with the fields: "name", "content".
9. The "content" field should be a JSON object with "question", "options", "answer", and "explanation".
10. Return JSON only.
11. Do not include any extra fields outside the required structure.

Output:

{{
    "lesson_items": [
        {{
            "name": "",
            "description": "",
            "techniques": [
                {{
                    "name": "",
                    "markdown": ""
                }}
            ],
            "assessments":[ 
                {{
                    "name": "",
                    "content": {{
                        "question": "",
                        "options": [],
                        "answer": "",
                        "explanation": ""
                    }}
                }}
            ]
        }}
    ]
}}
"""



# ==========================================================
# TECHNIQUE GENERATION
# ==========================================================


TECHNIQUE_GENERATION_PROMPT = """
You are generating one learning technique.

Use the provided technique pool to inspire a new, user-friendly teaching technique.

Goal:

{goal}


Topic:

{topic}


Technique Pool:

{technique_pool}


{preferred_techniques}


Instructions:
- Choose one technique or combine ideas from the pool.
- If preferred techniques are provided, favor them.
- Generate a clear name and a Markdown explanation.
- Return valid JSON only.

JSON format:
{{
    "name": "",
    "markdown": ""
}}
"""



# ==========================================================
# ASSESSMENT GENERATION
# ==========================================================


ASSESSMENT_GENERATION_PROMPT = """
You are generating one learning assessment.

Use the provided assessment pool to inspire a new, practical assessment.

Goal:

{goal}


Topic:

{topic}


Assessment Pool:

{assessment_pool}


{preferred_assessments}


Rules:
- Choose one assessment type from the pool or combine ideas from the list.
- If preferred assessments are provided, favor them.
- Match the user's topic and level.
- Return valid JSON only.

Expected format:
{{
    "name": "",
    "content": {{
        "question": "",
        "options": [],
        "answer": "",
        "explanation": ""
    }}
}}
"""