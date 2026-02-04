# Copilot Instructions for this repository ✅

## Project Overview 💡
- This repository is a mixed-language, small-scale data and experimentation workspace (CSV datasets, R scripts, MATLAB `.m` files, and Jupyter notebooks). The primary runnable Python artifact is `healthcare_crew.py`, an experimental CrewAI + LangChain assembly for a supervised, safety-conscious healthcare workflow.

## Key files & entry points 🔧
- `healthcare_crew.py` — Defines `Agent`, `Task`, `Crew` and a simple `tool` function. This is the canonical example of how agents and tasks are declared and wired using `crewai` and `langchain`.
- `.env` — Holds keys; contains an `OPENAI_API_KEY` placeholder and `CREWAI_TRACING=true`. Do not commit real secrets.
- Notebooks: `Data_visualization1.ipynb`, `Pandas (1).ipynb` — data exploration and plotting; some cells assume Google Colab (e.g., `google.colab.drive`).
- Data files at repo root: `Automobile.csv`, `Customer.csv`, `Titanic+Data+Set.csv`, `Melbourne_Housing.csv`, `honeyproduction1998-2016.csv`.
- R scripts: `*.R` and MATLAB scripts: `*.m` — standalone analysis; no Python wrappers present.

## Dependencies & environment ⚙️
- Primary Python dependencies observed:
  - `crewai`, `langchain`, `python-dotenv` (via `from dotenv import load_dotenv`), plus common data libs used in notebooks (`pandas`, `numpy`, `matplotlib`, `seaborn`).
- Recommended quick setup to run `healthcare_crew.py` (example):
  - python -m venv .venv
  - .venv\Scripts\activate  (Windows) or `source .venv/bin/activate` (Unix)
  - pip install crewai langchain python-dotenv
  - Set environment variables: `OPENAI_API_KEY` and optionally `CREWAI_TRACING=true` in `.env`
- There is no `requirements.txt` or lockfile. If you add/upgrade packages, include `requirements.txt` with pinned versions.

## Project-specific patterns & conventions 🧭
- Agent pattern:
  - Agents are defined with `Agent(role=..., goal=..., backstory=..., verbose=True)`; keep `role`, `goal`, and `backstory` concise and safety-focused.
  - Example: `supervisor` is a coordinating manager (`manager_agent=supervisor`).
- Task pattern:
  - Use `Task(description=..., expected_output=..., agent=...)` to document the intent and expected format.
  - `expected_output` strings are used as a brief contract for what the agent should produce.
- Crew assembly:
  - `Crew(agents=[...], tasks=[...], process=Process.hierarchical, manager_agent=..., verbose=True)` — adding a new agent requires including it in `agents` and adding its related `Task` to `tasks`.
- Tools:
  - Decorate helper functions with `@tool` (`langchain.tools.tool`) for agent-accessible utilities (see `severity_score(...)`). Keep tool signatures small and typed.

## Safety & content guidance (important) ⚠️
- `healthcare_crew.py` explicitly models a safety-first workflow:
  - The `Symptom Analyst` and `Risk & Safety Checker` roles must **avoid diagnostic claims** and **prioritize escalation** when red flags exist.
  - Tasks and backstories contain explicit non-diagnostic language — preserve it when editing or adding agents/tasks.
- Do not embed real API keys in the repository. Use `.env` or CI secrets.

## Running & validating changes ✅
- To run the crew example locally: `python healthcare_crew.py`. Expect a `kickoff` call and printed final output.
- When changing agents or tasks:
  - Maintain clear `description` and `expected_output` text for each `Task` (these serve as implicit tests).
  - Preserve or strengthen safety instructions in `backstory` and `description` fields.
- Notebooks may rely on Colab-specific imports; run them in an appropriate environment or adjust imports if running locally.

## PR checklist for contributors 📋
- [ ] No secrets committed (`OPENAI_API_KEY` must be omitted or placeholder).
- [ ] Add/Update `requirements.txt` when adding dependencies.
- [ ] Run `python healthcare_crew.py` and ensure no regressions in printed outputs.
- [ ] Keep medical/health-related language non-diagnostic and safety-oriented.

---

If anything here is unclear or you'd like more specific guidance (for example: creating unit tests for the `Crew` flow, or converting notebooks to reproducible scripts), tell me what part to expand and I will iterate. 💬
