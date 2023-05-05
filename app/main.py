import pandas as pd
from fastapi import FastAPI
import mlflow.pyfunc
import os

app = FastAPI()


# debugpy.listen(("0.0.0.0", 5678))
# print("Waiting for client to attach...")
# debugpy.wait_for_client()

@app.get("/")
def check():
    model_path = os.path.join(os.getcwd(), "models/3/809080238ef74723b258f2af51dc81ee/artifacts/vader_model")
    if os.path.exists(model_path):
        model = mlflow.pyfunc.load_model("models/3/809080238ef74723b258f2af51dc81ee/artifacts/vader_model")
        queries = ["This is a bad class. I hate MLOps and the professor! :-C. But our campus is good.",
                   "Lovely weather during the weekend.",
                   "LOL, this guy fell off a chair while listening the professor.",
                   "This is INSANE! How can you do such TERRIBLE thing?????"]

        scores_ = []
        for q in queries:
            m_input = pd.DataFrame([q])
            scores = model.predict(m_input)
            scores_.append([q, str(scores[0])])

            return {"scores": scores_}
    else:
        return {"error": "Model not found!"}


if __name__ == "__main__":
    print("Hello World!!")
