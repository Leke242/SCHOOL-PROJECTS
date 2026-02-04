
from dotenv import load_dotenv
load_dotenv()

from crewai import Agent, Task, Crew, Process
from langchain.tools import tool


# TOOLS


@tool
def severity_score(duration_days: int, pain_level: int) -> str:
    """Estimate symptom severity based on duration and pain level (1-10)."""
    score = duration_days + pain_level
    if score >= 15:
        return "High severity"
    elif score >= 8:
        return "Moderate severity"
    else:
        return "Low severity"



# AGENTS


supervisor = Agent(
    role="Healthcare Supervisor",
    goal="Orchestrate healthcare agents safely and efficiently",
    backstory="You coordinate medical advisory agents while enforcing safety rules.",
    verbose=True
)

intake_agent = Agent(
    role="Intake & History Collector",
    goal="Collect complete symptom and health history",
    backstory="You ask clear, neutral questions to understand the user's condition.",
    verbose=True
)

symptom_analyst = Agent(
    role="Symptom Analyst",
    goal="Analyze symptoms and suggest possible non-diagnostic explanations",
    backstory="You reason carefully and never provide a medical diagnosis.",
    verbose=True
)

risk_checker = Agent(
    role="Risk & Safety Checker",
    goal="Detect red flags and enforce medical disclaimers",
    backstory="You prioritize patient safety and escalate when needed.",
    verbose=True
)

recommendation_agent = Agent(
    role="Health Recommendation Educator",
    goal="Provide safe, educational advice and next steps",
    backstory="You explain health information clearly and responsibly.",
    verbose=True
)


# TASKS (workflow )


intake_task = Task(
    description="""
    Ask the user about:
    - Age
    - Main symptoms
    - Duration (days)
    - Pain level (1–10)
    - Any known conditions
    """,
    expected_output="""
    A clear summary of the user's symptoms, duration, pain level,
    age, and relevant medical background.
    """,
    agent=intake_agent
)

analysis_task = Task(
    description="""
    Analyze the symptoms provided.
    Suggest possible explanations for the symptoms.
    This is for educational purposes only.
    Do NOT provide a diagnosis.
    """,
    expected_output="""
    A list of possible non-diagnostic explanations written
    in cautious, educational language.
    """,
    agent=symptom_analyst
)

risk_task = Task(
    description="""
    Check for medical red flags such as severe pain, high fever,
    or worsening symptoms.
    Advise urgent medical care if necessary.
    Include a medical disclaimer.
    """,
    expected_output="""
    A safety assessment indicating whether symptoms are low,
    moderate, or high risk, including escalation advice if needed.
    """,
    agent=risk_checker
)

recommendation_task = Task(
    description="""
    Provide safe self-care advice if symptoms are low risk.
    Explain when to see a doctor.
    Suggest follow-up actions or monitoring.
    """,
    expected_output="""
    Clear, safe, and educational recommendations and next steps
    appropriate to the assessed risk level.
    """,
    agent=recommendation_agent
)


# CREW


healthcare_crew = Crew(
    agents=[
        
        intake_agent,
        symptom_analyst,
        risk_checker,
        recommendation_agent
    ],
    tasks=[
        intake_task,
        analysis_task,
        risk_task,
        recommendation_task
    ],
    process=Process.hierarchical,
    manager_agent=supervisor,
    verbose=True
)



if __name__ == "__main__":
    result = healthcare_crew.kickoff(
        inputs={
            "user_query": "I have had a headache and fever for 3 days"
        }
    )
    print("\nFinal Output:\n")
    print(result)

