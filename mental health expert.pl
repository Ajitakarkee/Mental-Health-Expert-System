% Facts and Rules for Emotional State Classification

% Stress thresholds based on input and biometrics
stress_level(low, Stress, HeartRate) :- Stress =< 3, HeartRate < 70.
stress_level(moderate, Stress, HeartRate) :- Stress > 3, Stress =< 6, HeartRate >= 70, HeartRate < 100.
stress_level(high, Stress, HeartRate) :- Stress > 6, HeartRate >= 100.

% Mood thresholds
mood_status(happy, Mood) :- Mood >= 8.
mood_status(neutral, Mood) :- Mood >= 5, Mood < 8.
mood_status(sad, Mood) :- Mood < 5.

% Heart rate classification ranges based on age
heart_rate_range(Age, HeartRate, Classification) :-
    (Age < 30 ->
        heart_rate_range_20_to_29(HeartRate, Classification)
    ; Age >= 30, Age < 40 ->
        heart_rate_range_30_to_39(HeartRate, Classification)
    ; Age >= 40, Age < 50 ->
        heart_rate_range_40_to_49(HeartRate, Classification)
    ; Age >= 50, Age < 60 ->
        heart_rate_range_50_to_59(HeartRate, Classification)
    ; Age >= 60 ->
        heart_rate_range_60plus(HeartRate, Classification)
    ).

% Heart rate classification for age 20-29
heart_rate_range_20_to_29(HeartRate, "Low Stress") :-
    HeartRate < 100, !.
heart_rate_range_20_to_29(HeartRate, "Moderate Stress") :-
    HeartRate >= 100, HeartRate < 140, !.
heart_rate_range_20_to_29(HeartRate, "High Stress") :-
    HeartRate >= 140, !.

% Heart rate classification for age 30-39
heart_rate_range_30_to_39(HeartRate, "Low Stress") :-
    HeartRate < 95, !.
heart_rate_range_30_to_39(HeartRate, "Moderate Stress") :-
    HeartRate >= 95, HeartRate < 135, !.
heart_rate_range_30_to_39(HeartRate, "High Stress") :-
    HeartRate >= 135, !.

% Heart rate classification for age 40-49
heart_rate_range_40_to_49(HeartRate, "Low Stress") :-
    HeartRate < 90, !.
heart_rate_range_40_to_49(HeartRate, "Moderate Stress") :-
    HeartRate >= 90, HeartRate < 130, !.
heart_rate_range_40_to_49(HeartRate, "High Stress") :-
    HeartRate >= 130, !.

% Heart rate classification for age 50-59
heart_rate_range_50_to_59(HeartRate, "Low Stress") :-
    HeartRate < 85, !.
heart_rate_range_50_to_59(HeartRate, "Moderate Stress") :-
    HeartRate >= 85, HeartRate < 125, !.
heart_rate_range_50_to_59(HeartRate, "High Stress") :-
    HeartRate >= 125, !.

% Heart rate classification for age 60+
heart_rate_range_60plus(HeartRate, "Low Stress") :-
    HeartRate < 80, !.
heart_rate_range_60plus(HeartRate, "Moderate Stress") :-
    HeartRate >= 80, HeartRate < 120, !.
heart_rate_range_60plus(HeartRate, "High Stress") :-
    HeartRate >= 120, !.

% Recommendations based on stress levels and mood
recommendation(low, happy, "Keep enjoying your activities and stay positive!").
recommendation(low, neutral, "Take a relaxing walk or spend time on a hobby.").
recommendation(low, sad, "Do something that cheers you up, like listening to music or talking to a friend.").
recommendation(moderate, _, "Try a mindfulness exercise like guided meditation or journaling.").
recommendation(high, _, "Practice deep breathing or consider talking to a therapist.").

% Main rule to determine recommendation
mental_health_recommendation(StressInput, AgeInput, HeartRateInput, MoodInput, Recommendation) :-
    % Check if the heart rate corresponds to the stress classification
    heart_rate_range(AgeInput, HeartRateInput, StressClassification),
    % Check mood status
    mood_status(MoodState, MoodInput),
    % Determine stress recommendation
    (StressInput =< 3 -> StressLevel = low
    ; StressInput > 3, StressInput =< 6 -> StressLevel = moderate
    ; StressInput > 6 -> StressLevel = high),
    % Combine the recommendations for mood and stress
    recommendation(StressLevel, MoodState, Recommendation).

% Entry point for user input simulation
start :-
    write("Enter your age: "), readln([AgeInput]),
    write("Enter your stress level (1-10): "), readln([StressInput]),
    write("Enter your heart rate: "), readln([HeartRateInput]),
    write("Enter your mood level (1-10): "), readln([MoodInput]),

    % Get the heart rate stress classification based on age
    heart_rate_range(AgeInput, HeartRateInput, StressClassification),
    write("Heart Rate Classification: "), write(StressClassification), nl,

    % Get the mental health recommendation
    mental_health_recommendation(StressInput, AgeInput, HeartRateInput, MoodInput, Recommendation),
    nl, write("Based on your inputs, we recommend: "), nl,
    write(Recommendation), nl.
