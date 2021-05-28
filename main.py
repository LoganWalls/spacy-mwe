import spacy
from datasets import load_dataset

spacy.prefer_gpu()

dataset = load_dataset("wikitext", "wikitext-2-raw-v1").filter(bool, input_columns=["text"])
nlp = spacy.load("en_core_web_trf", exclude=["ner"])
docs = list(nlp.pipe((x["text"] for x in dataset["test"])))