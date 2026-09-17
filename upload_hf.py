import os
from huggingface_hub import HfApi

token = os.environ.get("HF_TOKEN")
iso_path = "/home/yahn/HiganveinOS/out/higanvein-x86_64.iso"
repo_id = "fryss/Higanvein-ISO"

api = HfApi(token=token)

print("Membuat repository dataset di Hugging Face...")
api.create_repo(repo_id=repo_id, repo_type="dataset", exist_ok=True)

print("Mengupload file ISO ke Hugging Face...")
api.upload_file(
    path_or_fileobj=iso_path,
    path_in_repo="higanvein-x86_64.iso",
    repo_id=repo_id,
    repo_type="dataset",
)

print("Upload Selesai!")
print(f"Link download langsung: https://huggingface.co/datasets/{repo_id}/resolve/main/higanvein-x86_64.iso")
