import streamlit as st
import vertexai
from vertexai.generative_models import GenerativeModel
import argparse
import sys

context = [
        "You are a personal assistant for google cloud developers.",
        "Your mission is to give answers related to google cloud platform questions.",
        "By default reply in hungarian if other language is not used.",
    ]

parser = argparse.ArgumentParser()

# Adding optional argument
parser.add_argument("--project_id", type=str, help = "Pass GCP Project ID")
parser.add_argument("--location", type=str, help = "Pass Cloud Run location", default="europe-west1")

# Read arguments from command line
args = parser.parse_args()

# Check if the flag is missing
if args.project_id is None:
    print("Error: The '--project_id' flag is required!")
    parser.print_help()
    sys.exit(1)  # Exit with nonzero status

class Vertex_AI:
    def __init__(self, PROJECT_ID, location):
        self.PROJECT_ID = PROJECT_ID
        self.location = location

        vertexai.init(project=self.PROJECT_ID, location=self.location)
        self.model = GenerativeModel("gemini-1.5-flash-001", system_instruction=context)

    def generate_response(self, msg):
        response = self.model.generate_content(msg)
        return response
    
            
def add_username(username):
    if len(username) < 3:
        st.warning("username must be between 3 and 20 characters")
    else:
        st.session_state["username"] = username
        st.session_state["logged_in"] = True


def login_comp():
    username = st.text_input("Username", key="username", max_chars=20)
    
    st.button("Set Username", on_click=add_username, args=[username])


if __name__ == "__main__":

    if "username" not in st.session_state:
        st.session_state["username"] = ""
    if "logged_in" not in st.session_state:
        st.session_state["logged_in"] = False

    if not st.session_state["logged_in"]:
        login_comp()
    else:

        context.append(f"please refer user as {st.session_state['username']}")
        genAI = Vertex_AI(PROJECT_ID=args.project_id, location=args.location)

        st.title("Google Cloud Assistant")

        if "messages" not in st.session_state:
            st.session_state["messages"] = [{"role": "assistant", "content": f"Szia {st.session_state['username']}, miben segíthetek?"}]

        for msg in st.session_state.messages:
            st.chat_message(msg["role"]).write(msg["content"])

        if prompt := st.chat_input():

            st.session_state.messages.append({"role": "user", "content": prompt})
            st.chat_message("user").write(prompt)
            response = genAI.generate_response(prompt)
            msg = response.text
            st.session_state.messages.append({"role": "assistant", "content": msg})
            st.chat_message("assistant").write(msg)