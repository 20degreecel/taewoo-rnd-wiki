---
sidebar_label: '[26.03.04 08:23] Frontend Development Standards & Guidelines'
title: '[26.03.04 08:23] Frontend Development Standards & Guidelines'
---

# Frontend Development Standards & Guidelines

본 문서는 디에이 인포메이션 AX서비스기획 프론트엔드 프로젝트의 개발 일관성과 유지보수성을 높이기 위한 설계 표준 및 코딩 컨벤션입니다.

---

## 🏗️ 1. Directory Architecture (폴더 구조 표준)

React 애플리케이션의 재사용성과 관심사 분리를 위해 아래와 같은 폴더 구조를 강제합니다.

```
src/
├── api/             # 외부 API 통신을 위한 엔드포인트 래퍼 (Axios instance 등)
├── assets/          # 폰트, 이미지 등 정적 리소스 (.png, .ttf)
├── components/      # 재사용 가능한 UI 컴포넌트
│   ├── common/      # 전역 공통 컴포넌트 (Button, Modal, Input 등)
│   ├── layout/      # 레이아웃 컴포넌트 (Header, Sidebar)
│   └── views/       # 특정 도메인/페이지 종속적인 큰 단위의 뷰 컴포넌트
├── config/          # 환경 변수, 전역 설정, 라우트 정의 (.env 맵핑 등)
├── constants/       # 상수 데이터 관리 (ex. API URL, 에러 코드 상수화)
├── data/            # Mock 데이터 관리 (실 서버 연동 전 임시 사용)
├── hooks/           # Custom React Hooks (useAuth, useModals 등)
├── store/           # 전역 상태 관리 스토어 (Zustand 등)
├── styles/          # 전역 CSS, Tailwind 확장 클래스
├── utils/           # 순수 자바스크립트 유틸리티 함수 (날짜, 포맷 관련 등)
└── App.jsx          # 최상위 컴포넌트 및 Provider/Router 진입점
```

---

## 🗂️ 2. Naming Conventions (네이밍 컨벤션)

### 2.1 파일 & 폴더
- **React 컴포넌트 파일**: `PascalCase`를 사용합니다. (예: `ProjectList.jsx`, `SmartDtiView.jsx`)
- **일반 자바스크립트 파일 (util, api 등)**: `camelCase`를 사용합니다. (예: `formatDate.js`, `apiClient.js`)
- **폴더명**: 기본적으로 `camelCase`를 사용하되, 컴포넌트가 그룹된 폴더는 컴포넌트명과 일치하는 `PascalCase`를 허용합니다. (예: `components/views/Dashboard`)

### 2.2 변수 & 함수
- **Component / Interface**: `PascalCase` (예: `function CardElement() { ... }`)
- **Variable / Function**: `camelCase` (예: `const isModalOpen`, `function fetchProjectData()`)
- **Boolean Variables**: `is`, `has`, `should` 등의 접두사를 사용합니다. (예: `isHidden`, `hasFeature`)
- **Event Handlers**: `handle` + 이벤트명 형식을 사용합니다. (예: `handleClick`, `onSubmit` (Props로 전달 시))
- **Constants (상수)**: `UPPER_SNAKE_CASE` (예: `MAX_API_RETRY_COUNT`, `DEFAULT_THEME`)

---

## 💡 3. Component Design & State Management

### 3.1 컴포넌트 설계 (Component Design)
- **단일 책임 원칙 (SRP)**: 하나의 컴포넌트는 한 가지 역할을 수행하도록 분리합니다.
- **Presentational & Container 패턴 차용**: 
  - 상태 조작과 데이터를 패칭하는 (Container) 기능과, UI 렌더링에만 집중하는 (Presentational) 기능을 분리하여 작성하는 것을 권장합니다.
- **Props 파라미터**: 컴포넌트의 Props가 4개 이상으로 많아질 경우, 구조 분해 할당(Destructuring)을 적극 활용하거나 객체로 묶어 전달합니다.

### 3.2 상태 관리 (State Management)
- **Local State (`useState`)**: 특정 컴포넌트 내부에서만 쓰이는 상태 (예: 모달 On/Off, 드롭다운 토글 여부 등)
- **Global State**: 
  - 여러 컴포넌트/페이지에 걸쳐 공유되어야 하는 데이터 (예: 로그인 유저 정보, 현재 선택된 프로젝트, 활성화된 테마 등).
  - 본 프로젝트는 도입 비용이 낮고 직관적인 **Zustand** 또는 **Context API** 사용을 기본으로 채택합니다.
- **Server State**:
  - API 호출 등 백엔드 통신 피드백(로딩, 에러, 캐싱)이 필요한 데이터는 **TanStack Query (React Query)** 의 사용을 권장합니다.
  - `useEffect`로 직접 Fetching하는 것은 Mock 데이터나 단순 테스트 시에만 사용합니다.

---

## 🎨 4. Styling & CSS (스타일링 표준)

본 프로젝트는 **Tailwind CSS**를 메인 스타일링 엔진으로 사용합니다.

- **인라인 스타일 금지**: `style={{ marginTop: '10px' }}`와 같은 인라인 속성 대신 Tailwind의 Utility Class(`mt-2.5`)를 사용합니다.
- **임의값(Arbitrary values) 지양**: `w-[325px]`와 같은 임의값은 피하고 가급적 사전 정의된 속성을 사용하되, 불가피한 디자인의 위치 세부 조정 때만 예외적으로 사용합니다.
- **반복되는 UI 패턴 축약 (Component Abstraction)**: 버튼, 뱃지 등 자주 사용되는 조합은 Tailwind의 `@apply`를 통해 `styles/index.css`에 확장하거나 Base UI Component로 분리합니다.
- **가독성 강화**: 클래스 선언이 길어지는 요소는 레이아웃 → 크기 → 타이포그래피 → 시각적 효과 순의 논리적 배치 컨벤션을 따릅니다.

---

## ⚙️ 5. Clean Code & Code Quality

### 5.1 안전한 코드 작성
- 옵셔널 체이닝(`?.`) 및 널 병합 연산자(`??`)를 사용하여 데이터 바인딩 시 NullPointerException 에러가 화면을 깨뜨리는 것을 방지합니다.
- 매직 넘버(Magic Number) 및 하드 코딩 텍스트를 `constants` 폴더 안의 상수로 치환합니다.

### 5.2 API 에러 핸들링
- Axios 인터셉터(Interceptors) 측에서 글로벌 범위의 에러 처리 (ex. 401 토큰 만료 시 자동 로그아웃)와 Toast/Alert 호출을 통일하여 처리합니다.

### 5.3 린팅(Linting) 및 포매팅
- 본 프로젝트는 `ESLint`와 `Prettier` 체계를 따릅니다.
- 개발자는 커밋(Commit) 전 반드시 린트 룰(Lint rule) 위반 사항과 미사용 변수가 없도록 자동 포매팅을 진행합니다. (추후 Husky를 통한 Pre-commit hook 적용 제안)
