---
sidebar_label: '[26.03.09 09:17] Downloads Folder Organization Plan'
title: '[26.03.09 09:17] Downloads Folder Organization Plan'
---

# Downloads Folder Organization Plan

I will organize the files and folders in your `Downloads` directory into 6 main categories to make it cleaner. As requested, **no files will be deleted**.

## Proposed Changes

### [Component Name] Categorized Folders
I will create the following folders in `C:\Users\teoyo\Downloads`:

- `01_문서 (Documents)`: `.pptx`, `.pdf`, `.docx`, `.xlsx`, `.txt`, `.csv`
- `02_미디어 (Media)`: `.mp3`, `.mp4`, `.png`, `.jpg`, `.jpeg`, `.gif`
- `03_설치파일 (Installers)`: `.exe`, `.msi`, `.dmg`, `.zip`, `.tar.gz`
- `04_웹파일 (Web_Files)`: `.html`, `.css`, `.js` (many numbered html files)
- `05_기존폴더 (Folders)`: Loose folders that don't fit into obvious categories.
- `06_기타 (Others)`: Anything else or ambiguous files.

### [Component Name] Logic
1.  **Skip Core Folders**: I will NOT move important-looking folders like `VSCODE`, `AIDD`, `APP`, `Cakewalk`, `GIMP`, etc., unless they are very messy.
2.  **Move Files**: Files matching the extensions above will be moved to their respective folders.
3.  **Ambiguous Folders**: Folders that look like temporary "New Folder" or "반출" will be moved to `05_기존폴더` or `06_기타`.

## Verification Plan

### Automated Tests
- I will run `ls` after the organization to ensure the root `Downloads` folder is clean and the new folders contain the files.

### Manual Verification
- The user can check the `Downloads` folder to see if the organization meets their expectations.
