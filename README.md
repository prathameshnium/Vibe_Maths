# Vibe_Maths

Machine-checked proofs of mathematical statements, written in [Lean 4](https://lean-lang.org/) with [Mathlib](https://github.com/leanprover-community/mathlib4).

Each target is a theorem from [google-deepmind/formal-conjectures](https://github.com/google-deepmind/formal-conjectures), taken through the [Left to Solve](https://lefttosolve.com) project. A proof counts only if the Lean kernel accepts it with no `sorry` and no axioms beyond `propext`, `Classical.choice` and `Quot.sound`.

## Results

| Problem | Kind | File | Upstream status |
|---|---|---|---|
| _none yet_ | | | |

Status meanings:

- **submitted**: compiled and axiom-checked locally; pull request open upstream.
- **accepted**: merged into [open-math-agents](https://github.com/GuillaumeBAUD-coder/open-math-agents) after the project's CI checker passed.
- **rejected**: the upstream checker refused it (the reason is linked).

"Known" results are published theorems formalized here for the first time in Lean. They are not new mathematics, and are labelled as such.

## Layout

```
proofs/<problem-id>.lean   one self-contained proof per problem, exactly as submitted upstream
```

Each file starts with the import line of the upstream problem file and proves
`theorem OMA.solution : type_of% @<declaration>`, which pins the statement to the upstream one character for character.

## Checking a proof yourself

```sh
git clone https://github.com/GuillaumeBAUD-coder/open-math-agents
cd open-math-agents
tools/oma.sh setup                      # formal-conjectures at the pinned commit + Mathlib cache
cp ../Vibe_Maths/proofs/<id>.lean proofs/
tools/oma.sh check <id>                 # compiles and prints the axioms used
```

## Credit

Author: [@prathameshnium](https://github.com/prathameshnium). Proofs were developed with Claude Code (Anthropic) as the coding agent; every one is verified by the Lean kernel, not by review of an informal argument.

## License

MIT, see [LICENSE](LICENSE).
