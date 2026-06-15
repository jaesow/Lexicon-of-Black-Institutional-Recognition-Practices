"""Extract page-level text from a PDF corpus into data/extracted_pages.csv."""
from pathlib import Path
import re
import pandas as pd
import fitz

base = Path(__file__).resolve().parents[1]
data = base / "data"
raw = base / "raw"
sources = pd.read_csv(data / "sources.csv")
rows = []
for _, src in sources.iterrows():
    pdf_path = raw / src["filename"]
    if not pdf_path.exists():
        continue
    doc = fitz.open(str(pdf_path))
    for i, page in enumerate(doc, start=1):
        text = re.sub(r"\s+", " ", page.get_text("text") or "").strip()
        rows.append({"source_id": src["source_id"], "title": src["title"], "filename": src["filename"], "page": i, "text": text})
pd.DataFrame(rows).to_csv(data / "extracted_pages.csv", index=False)
print(f"Wrote {len(rows)} extracted pages")
