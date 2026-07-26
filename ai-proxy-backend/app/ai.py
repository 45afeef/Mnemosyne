from openai import OpenAI

from .config import AI_API_KEY, MODEL

client = OpenAI(api_key=AI_API_KEY)


def ask_ai(system_prompt: str, user_prompt: str) -> str:
    response = client.chat.completions.create(
        model=MODEL,
        messages=[
            {
                "role": "system",
                "content": system_prompt,
            },
            {
                "role": "user",
                "content": user_prompt,
            },
        ],
    )

    return response.choices[0].message.content