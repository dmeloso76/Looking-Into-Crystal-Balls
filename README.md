# Contents

## Folder ZTree
Code used for all treatments (including treatment CU that was excluded from the main paper). To run the programs in this folder, the running computer must have an installation of ZTree, the client computers must have an installation of ZLeaf, and running and client computers must be connected on a local network. Files explained in folder README.

## Data
Raw data output from all treatments, with treatment and session identifiers. The variables are:

* period_in_session: each session had 64 periods.
* subject: unique participant identifier for the experiment.
* behavioral_evaluator_choice: 
* bayes_evaluator_choice:
* session: twelve sessions, 2 of treatment CC, 2 of CU, 4 of CL, and 4 of HF.
* subject_in_session: unique participant identifier for the session.
* group: in each period of each session, unique identifier of each reporter-evaluator pair.
* q: either 6 or 8; the number of balls with a blue core present in the urns from which a ball is drawn. The value is unique for each block - a set of 16 periods.
* bluecore: for each group (reporter-evaluator pairing in a period) and period, a dummy equaling 1 if the core of the drawn ball is blue, and 0 if it is orange.
* blueshell: for each group and period, a dummy equaling 1 if the shell of the drawn ball is blue, and 0 if it is orange.
* block: four blocks per session. Block 1 contains periods 1 to 16, block 2 contains periods 17 to 32, block 3 contains periods 33 to 48, and block 4 contains periods 49 to 64.
* period_in_block: each block had 16 periods.
* evaluator_choice: for each group, the choice, in percentage, made by the computerized or human evaluator.
* payoff: payoff for a given period and participant.
* game: treatment game, either CC, CU, CL, or HF.
* order: each session alternated blocks with Q=6 and Q=8. In blocks with order = 6868, the first block had Q=6. In those with order = 8686, the first block had Q=8.
* bluereport: for each group and period, dummy equal to 1 if the sent report was Blue, and 0 if it was Orange.
* period_in_treatment: in each session, there were two blocks with the same value of Q, for a total of 32 periods in a treatment (value of Q).
* role: participant's role, either reporter or evaluator. The role was fixed for the session.
* urn: urn from which the ball was drawn, either informative or uninformative.
* reporter_choice: for each group and period, strategy chosen by the reporter, either lie (misreport) or truth (thruth-telling).
* reporter_truth: for each group and period, a dummy equaling 1 if the reporter chose truth-telling, and 0 if they chose misreporting.
* q8: a dummy equaling 1 if the current block has Q=8 and 0 otherwise.
* lateblock: a dummy equaling 1 if the current block is the second block with the same value of Q, and 0 if it is the first one.
* cc: a dummy equaling 1 if the treatment game of the current session is CC, and 0 otherwise.
* hf: a dummy equaling 1 if the treatment game of the current session is HF, and 0 otherwise.
* cl: a dummy equaling 1 if the treatment game of the current session is CL, and 0 otherwise.
* ca: a dummy equaling 1 if the treatment game of the current session is CA, and 0 otherwise.
* orangerepot_orangecore: for each group and period, a dummy equaling 1 if the core was orange and the report was Orange, and 0 otherwise.
* bluereport_bluecore: for each group and period, a dummy equaling 1 if the core was blue and the report was Blue, and 0 otherwise.
* bluereport_orangecore: for each group and period, a dummy equaling 1 if the core was orange and the report was Blue, and 0 otherwise.
* orangereport_bluecore: for each group and period, a dummy equaling 1 if the core was blue and the report was Orange, and 0 otherwise.
* oreport_ocore_vs_breport_bcore: equal to bluereport_bluecore, restricted to data containing 1 in either bluerport_bluecore or orangereport_orangecore.
* breport_bcore_vs_breport_ocore: equal to bluereport_orangecore, restricted to data containing 1 in either bluereport_orangecore or bluereport_bluecore.
* breport_ocore_vs_oreport_bcore: equal to orangereport_bluecore, restricted to data containg 1 in either orangereport_bluecore or bluereport_orangecore. 


