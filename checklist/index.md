# Checklists

<p class="subtitle" markdown="1">your job is to make sure</p>

<div class="syllabus" markdown="1">

**Learning Objectives**

-   Reframe individual-contributor technical practices as management responsibilities.
-   Distinguish between claiming a practice is followed and having evidence it is followed.
-   Identify the compliance and safety obligations most likely to apply to your project.

</div>

## Before

Jess reviewed Ren's first pull request thirty minutes after he submitted it.
The code was fine,
but the commit message included a line that said `export API_KEY=sk-proj-abc123...`
because Ren had pasted his test setup into the commit.
The key was now in git history.
Even after Jess asked him to remove it,
it remained accessible in the repository's history to anyone who knew to look.

The API key was revoked within an hour.
But the incident revealed that Jess had no process for catching this class of problem
before a commit was merged.
She had assumed Ren would know not to commit credentials;
Ren had assumed credentials in commit messages were fine
because nobody had told him otherwise.

## Trust, But Verify

When Jess was a grad student,
her job was to write tests and meaningful commit messages.
Now, as team lead,
her job is to make sure the team does these things consistently,
even when she isn't watching.
This shift is larger than it sounds.
As an individual contributor,
you can rely on your own habits.
As a manager,
you can't rely on anyone's habits,
particularly under pressure when it matters most.

<div class="callout" markdown="1">

[%b Gawande2009 %] studied why expert surgeons skip steps they know perfectly well
in the middle of complex procedures.
The answer is that expertise and pressure interact badly:
the more confident you are in a step,
the more likely you are to skip it when you are busy.
A checklist isn't an insult to your competence;
it is protection against the predictable effects of stress and distraction.

</div>

## Claims vs. Evidence

"We use code review" is a claim.
"Every PR in our GitHub history has at least one approval before merge" is
checkable evidence to back up that claim.
The people who might ask for evidence include grant funders,
institutional compliance officers,
collaborators deciding whether to depend on your software,
and your future self trying to understand why a decision was made two years ago.

An [%g audit-trail "audit trail" %] is not surveillance.
You are not tracking your team members to catch them doing something wrong:
you are doing it to prevent mishaps.
The practices below are a review, not a tutorial.
The key question for each one is whether there is evidence that your team follows them.

Version control
:   Commit messages explain why a change was made; no secrets or
    credentials are committed; feature branches are used rather than
    committing directly to main.

Code review
:   Every merge has at least one reviewer who is not the author;
    reviews happen within an agreed time window, not "whenever";
    review comments are addressed, not just dismissed.

Testing
:   [%g unit-test "Unit tests" %] are run before every merge; CI is configured and a failing
    build blocks the merge; coverage is tracked and not declining.
    [%g tdd "Test-driven development" %] is one way to ensure
    that tests exist before code is merged [%b Petre2014 %].

Dependencies
:   Versions are pinned; `pip audit` or the equivalent runs regularly;
    someone is responsible for acting on vulnerability reports.

Documentation
:   Every public function has a docstring; every release has a
    changelog entry; the README contains at least one working example.

<div class="callout" markdown="1">

The list above is intimidating,
and very few projects do everything in it.
Rather than overwhelming yourself,
discuss it with the team and pick one thing to implement first.
The change that usually pays off fastest is branch protection,
i.e.,
requiring at least one review before merge.
This catches lots of accidental mistakes
without requiring any configuration beyond a checkbox.

</div>

## Safety and Compliance

Research software often has obligations that other open-source software doesn't:

Data privacy
:   If your software touches data about human subjects, you are in
    data privacy territory even if the software itself is open
    source. "Anonymized" is not a safe harbor: re-identification
    attacks are routine.

Ethics review
:   Software that collects or processes data about human subjects may
    require ethics board approval even if the software is just a
    tool. Your institution's review board, not a web search, is the
    right place to ask. Not asking is not a defense.

Secrets in version control
:   API keys, passwords, and personal data committed to git are not
    gone when deleted: they live in history. Tools like `git-secrets`
    or `trufflehog` detect them. [%g secret-rotation "Key rotation" %],
    not deletion, is the fix when accidents happen.

Licensing
:   A contributor who adds [%g gpl "GPL" %] code to your
    [%g mit-license "MIT" %]-licensed project changes the license of
    the whole project. A Contributor License Agreement or Developer
    Certificate of Origin clarifies who owns what before it becomes a
    problem.

Export controls
:   Accepting contributions from people in certain countries may be
    subject to export control regulations. This is your institution's
    legal team's problem, but you need to know the question exists.

<div class="callout" markdown="1">

Pre-commit hooks and CI don't enforce themselves:
someone needs to be responsible for acting when a check starts failing.
Name that person in CONTRIBUTING.md.

</div>

## After

After the API key incident,
Jess added `git-secrets` to the repository's pre-commit hooks
and wrote a two-paragraph credential policy in `CONTRIBUTING.md`.
She then did a compliance check on the rest of the project
and found that the simulator processed GPS location data from wildlife collars
that had been provided by a government agency under a data sharing agreement
that she had never read.
It turned out there were restrictions on redistribution
that ruled out the way she had been sharing sample data in the test suite.
It took her a week to untangle that—a week she couldn't spend
adding new features or fixing other bugs.

<div class="callout" markdown="1">

The right first question about any compliance issue is almost never, "Is this allowed?"
It is, "Who at my institution knows the answer?"
because the answer is always institution-specific and jurisdiction-specific.
The library's research data management office,
the legal counsel's office,
and the IRB office each own different parts of the answer.
Asking a search engine or an LLM is not the same as asking any of them.

</div>

## What About AI?

-   Positive:
    An LLM can generate a first draft of an onboarding checklist
    from existing documentation like `CONTRIBUTING.md` or `README.md`.
    It can also catch gaps between what the docs say and what the repo actually requires,
    e.g., a CI step that isn't documented,
    which is particularly helpful as the project evolves.

-   Negative:
    Contributors increasingly use LLMs to fill out PR checklists,
    answering "yes, I tested this" because the LLM suggested it
    rather than because they ran the tests.
    A  checklist item that can be answered by an LLM without actually being run
    is not a safety check: it's theater.

-   A specific technique to add:
    ask contributors to paste the actual test output or CI run link next to checklist items,
    not just a checkbox.
    This is one thing LLMs cannot yet fabricate convincingly in a verifiable way.

## Exercises

<section class="exercise" markdown="1">

### How to Check (5 min)

The list below gives specific things to look for when doing an audit of practices.
Add three more,
two of which cover areas that these three don't.

-   Version control: a branch protection rule in GitHub.
-   Code review: a rule requiring reviewers on PRs before merging.
-   Testing: coverage reports checked into version control.

</section>

<section class="exercise" markdown="1">

### Practice Audit (8 min)

Go through the practices checklist provided earlier.
Mark each item: yes (with evidence), probably, no, or don't know.

1.  For each "yes", write one sentence of evidence:
    Not "we use CI" but
    "CI is configured in `.github/workflows/` and the badge on the README shows current status".

2.  For each "don't know",
    write the name of one person on your team who does know.
    If you don't know who knows, write that too.

</section>

<section class="exercise" markdown="1">

### Compliance Check (7 min)

Repeat the audit using an LLM:

> Review my project's practices against this checklist: [paste checklist items].

> Based on what I tell you about my project
> [two or three sentences describing the project, its data, and its contributors],
> identify which compliance issues I should investigate.

Run the prompt.
Note what the LLM confidently asserted that it cannot actually know,
such as your institution's specific policies,
or your jurisdiction's legal requirements.
(It *may* be able to say useful things about data sharing agreements
if those are in the repository.)

</section>
