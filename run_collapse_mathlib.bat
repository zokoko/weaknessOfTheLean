@echo off
rem ============================================
rem  Verify Mathlib-based collapse experiment
rem  Uses pinned Lean v4.33.1 with full LEAN_PATH
rem  Double-click to run. Pure ASCII for cmd.exe.
rem  NOTE: this .lean imports Mathlib, so it depends on the
rem  precompiled Mathlib oleans in the copied repo below.
rem  It is NOT self-contained - copying only the two files
rem  to a new folder will NOT work elsewhere.
rem ============================================

set "LEAN=C:\Users\Administrator\.elan\toolchains\leanprover--lean4---v4.33.1\bin\lean.exe"
set "COPY=D:\project\math\7problems\riemann\alpoge-2026\lean-collapsed-copy"
set "ML=%COPY%\.lake\packages\mathlib"
set "FILE=%~dp0collapse_mathlib.lean"

set "LEAN_PATH=%ML%\.lake\build\lib\lean"
set "LEAN_PATH=%LEAN_PATH%;%ML%\.lake\packages\LeanSearchClient\.lake\build\lib\lean"
set "LEAN_PATH=%LEAN_PATH%;%ML%\.lake\packages\Qq\.lake\build\lib\lean"
set "LEAN_PATH=%LEAN_PATH%;%ML%\.lake\packages\aesop\.lake\build\lib\lean"
set "LEAN_PATH=%LEAN_PATH%;%ML%\.lake\packages\batteries\.lake\build\lib\lean"
set "LEAN_PATH=%LEAN_PATH%;%ML%\.lake\packages\importGraph\.lake\build\lib\lean"
set "LEAN_PATH=%LEAN_PATH%;%ML%\.lake\packages\plausible\.lake\build\lib\lean"
set "LEAN_PATH=%LEAN_PATH%;%ML%\.lake\packages\proofwidgets\.lake\build\lib\lean"

echo ==== Mathlib collapse experiment - Lean v4.33.1 ====
echo.
echo File: %FILE%
echo.
"%LEAN%" "%FILE%"
set "CODE=%errorlevel%"

echo.
echo ==== Exit code: %CODE% ====
echo ==== 0 = kernel OK, non-zero = error ====
echo ==== Expected axioms: propext, Classical.choice, Quot.sound ====
pause
