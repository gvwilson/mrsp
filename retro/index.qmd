# Retrospective

## What Was Wrong with Version 1

The first version of this workshop had two problems:

1.  Content was abstract. Each lesson surveyed six to eight topics at
    high altitude without giving learners anything concrete to think
    about or do. The Jess narrative described what a fictional person
    did, but didn't ask learners to connect it to their own work.
2.  Exercises couldn't be done in time, or had no clear deliverable.
    "Where are you now?"  with seven open questions takes an hour to
    discuss properly or five minutes to wave at.  "Draw a concept map
    for the thing you're working on" is fine if you've been taught how
    to draw concept maps; without that, learners stall.

In addition the first version of this workshop was written before LLM
coding assistants became mainstream.  Many RSEs now use LLMs for code,
documentation, and issue triage.

## The Design of Version 2

1.  Every session ends with something learners can take home and use
    right away.
1.  Every exercise is time-boxed.
1.  Jess is a worked example for every exercise, not just backdrop.
1.  Learners will use LLMs during exercises.

That last point needs some justification.
Research software engineers already use LLMs as coding assistants;
the workshop should model what good practice looks like
rather than pretending the tools don't exist.
Each exercise is designed accordingly:

1.  Exercises that produce generic documents provide a suggested prompt.
    Learners generate a first draft with LLM help,
    then critique it for their specific project.
1.  Exercises requiring judgment about real people,
    real trade-offs,
    or specific project history cannot be offloaded.
1.  Some role-play exercises use the LLM as the other party.
    This lets learners practice at their own pace and repeat if they want.
1.  The debrief for each session discuss common LLM errors.
