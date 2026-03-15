---
sidebar_label: '[26.03.04 08:04] UI/UX 화면 정의서 - Core Modules (DABICS, Smart DTI, DAPRE, DAPEPD)'
title: '[26.03.04 08:04] UI/UX 화면 정의서 - Core Modules (DABICS, Smart DTI, DAPRE, DAPEPD)'
---

# UI/UX 화면 정의서 - Core Modules (DABICS, Smart DTI, DAPRE, DAPEPD)

## 📌 1. DABICS (Data Explorer)
- **화면명**: 타겟 발굴 데이터 탐색기
- **목적**: 8대 암종 scRNA-seq 데이터를 탐색하고 타겟 유전자를 발굴함.
- **주요 뷰 구성**:
  1.  **Project List**: 8개의 암종 프로젝트 리스트. 클릭 시 우측 데이터 갱신.
  2.  **Summary Cards**: 세포 수, 유전자 수 등 통계 요약표.
  3.  **UMAP Projection**: 세포 클러스터링을 보여주는 2D/3D Scatter Plot (산점도 뷰어).
  4.  **Top Markers Panel**: `Adj.P-val`이 유의미한 상위 마커 유전자 리스트. 클릭 시 DANOVO/Smart DTI로 타겟을 전송하는 버튼 노출.

## 📌 2. Smart DTI (Hit Discovery)
- **화면명**: Smart DTI 히트 발굴
- **목적**: 자연어 프롬프트를 통해 5.5B 라이브러리 스크리닝 전략을 짜고 3D 구조 도킹 기반의 Hit를 선별하는 과정 프로세스 시각화.
- **주요 뷰 구성**:
  1.  **AI Strategy Input**: 대화형 프롬프트 입력창 "Ex: 폐암 관련 최신 논문을 요약하고..."
  2.  **GCN Weight Monitor**: 실행 후 GCN 엔진의 4가지 View(리간드, 표현형, 문헌, 지식그래프)의 가중치 할당 애니메이션 대시보드.
  3.  **Smart Funneling**: 55억 개 데이터 모델이 120M -> 500K -> Top 3로 좁혀지는 깔때기형(Funnel) 필터링 애니메이션 위젯.

## 📌 3. DAPRE (Prediction Feedback)
- **화면명**: DAPRE 예측 오차 반영
- **목적**: AI 예측 IC50 값과 Wet-lab 실험 Data(nM) 간의 갭을 모델에 피드백함.
- **주요 뷰 구성**:
  1.  **Evaluation List**: 합성/실험 대기 중인 후보물질 리스트.
  2.  **3D Viewer**: 3D 단백질-리간드 결합 뷰어 컴포넌트 활용 (React Three Fiber 등 기반).
  3.  **Feedback Form**: AI 예측치(Read-only) 옆에 실제 실험 데이터를 Number input으로 입력하고 "피드백"을 전송하는 제출 폼.

## 📌 4. DAPEPD (Peptide Design)
- **화면명**: DAPEPD 펩타이드 디자인
- **목적**: 고전적인 저분자(Small Molecule) 외 단백질 표면 바인더 역할을 하는 펩타이드 서열을 디자인함.
- **주요 뷰 구성**:
  1.  **3D Peptide Viewer**: 펩타이드 체인을 보여주는 전용 3D 뷰.
  2.  **Designed Binders List**: 구조의 신뢰도를 뜻하는 `pLDDT` 점수 등과 함께 추천 펩타이드 서열 리스트 노출.
