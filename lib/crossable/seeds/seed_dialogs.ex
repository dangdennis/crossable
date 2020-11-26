defmodule Crossable.Seeds.Dialogs do
  @moduledoc """
  Seed data for message links.
  """
  require Ecto.Query

  def run() do
    seed_thirty_day_dialogs()
    nil
  end

  def seed_thirty_day_dialogs() do
    {:ok, dialog_flow} =
      Crossable.Dialogs.create_dialog_flow(%{
        name: "30-day habit engagement"
      })

    thirty_day_engagement_dialog()
    |> Stream.with_index(1)
    |> Enum.map(fn {dm, idx} ->
      create_thirty_day_dialog_msg(dm, dialog_flow.id, idx)
    end)
  end

  def create_thirty_day_dialog_msg(
        dm,
        dialog_flow_id,
        sequence
      ) do
    case dm do
      %{
        root: root,
        yes: yes,
        no: no,
        tip: tip
      } ->
        # create the root message
        Crossable.Dialogs.create_dialog_message(%{
          dialog_flow_id: dialog_flow_id,
          sequence_position: sequence,
          content: root
        })

        # create the following yes, no, and tip messages (if any)
        Crossable.Dialogs.create_dialog_message(%{
          dialog_flow_id: dialog_flow_id,
          sequence_position: sequence,
          content: yes,
          response_match: "yes"
        })

        Crossable.Dialogs.create_dialog_message(%{
          dialog_flow_id: dialog_flow_id,
          sequence_position: sequence,
          content: no,
          response_match: "no"
        })

        Crossable.Dialogs.create_dialog_message(%{
          dialog_flow_id: dialog_flow_id,
          sequence_position: sequence,
          content: tip,
          response_match: "tip"
        })

      %{
        root: root,
        yes: yes,
        no: no
      } ->
        # create the root message
        Crossable.Dialogs.create_dialog_message(%{
          dialog_flow_id: dialog_flow_id,
          sequence_position: sequence,
          content: root
        })

        # create the following yes, no, and tip messages (if any)
        Crossable.Dialogs.create_dialog_message(%{
          dialog_flow_id: dialog_flow_id,
          sequence_position: sequence,
          content: yes,
          response_match: "yes"
        })

        Crossable.Dialogs.create_dialog_message(%{
          dialog_flow_id: dialog_flow_id,
          sequence_position: sequence,
          content: no,
          response_match: "no"
        })
    end
  end

  @doc """
  Creates a uniform map for the dialog messages.
  """
  def new_thirty_day_dialog_msg(sequence, root, yes, no) do
    %{
      sequence: sequence,
      root: root,
      yes: yes,
      no: no
    }
  end

  @doc """
  Creates a uniform map for the dialog messages with tip.
  """
  def new_thirty_day_dialog_msg(sequence, root, yes, no, tip) do
    %{
      sequence: sequence,
      root: root,
      yes: yes,
      no: no,
      tip: tip
    }
  end

  def thirty_day_engagement_dialog() do
    [
      new_thirty_day_dialog_msg(
        {1, 1},
        "Howdy! I’m your friendly CrossBot partner and I’ll be doing a daily checking with you for the next 30 days!",
        "Awesome!",
        "Drop a message in the #ask-the-team channel and one of our team (Human) will answer your question as soon as possible. Thanks!"
      ),
      new_thirty_day_dialog_msg(
        {1, 2},
        "Good morning! Did you get a chance to do your new habit yesterday?",
        "Well done friend. You're a hero!",
        "We all fall short sometimes. It happens. What defines us is our ability to come back."
      ),
      new_thirty_day_dialog_msg(
        {1, 3},
        "Hey teammate! How did it go yesterday? React 👍  if you did your habit and ❌ if not.",
        "Awesome work buddy! Keep it up.",
        "Not to worry, if you feel you need some support, reach out to a human member of the team on the #ask-the-team."
      ),
      new_thirty_day_dialog_msg(
        {1, 4},
        "Hello, this is your friendly CrossBot. We are on day 3 of your new habit! Did you complete your habit?",
        "You're a warrior - keep up the great work!",
        "That's okay. Hopefully it will be easier to find the time and motivation tomorrow.",
        """
        😇 Habit anchoring tip:
        Did you know that it’s easier to start a new habit if it’s anchored to an existing habit in your life?
        Like, if you wanted to wash your face more, you would say “after brushing my teeth at night, I will wash my face.” If you are having trouble remembering to do your habit, find another habit that you do every day to use as a trigger 💡.
        https://www.developgoodhabits.com/how-to-form-a-habit-in-8-easy-steps/ 
        """
      ),
      new_thirty_day_dialog_msg(
        {1, 5},
        "Hi folks, how’s it going? 5 days of Crossable and going strong 💪. React 👍 if you did your habit yesterday and if ❌ not.",
        "This is too easy for you! Maybe we need to increase the difficult settings!",
        "That sucks. No worries though and let the Crossable team know if you need any support on the #ask-the-team channel.",
        """
        😇 My 2 cents? In order to finish the week strong, make a plan now for when to accomplish your habit on Saturday and Sunday and when to rest!
        """
      ),
      new_thirty_day_dialog_msg(
        {1, 6},
        "What's up? Did you complete your habit?",
        "You make me so proud. I'm going to start running my pride protocol!",
        "Ah no worries. Visualize doing it tomorrow and how great it will feel to complete it tomorrow."
      ),
      new_thirty_day_dialog_msg(
        {1, 7},
        "You know the drill.",
        "Excellent work my friend - see you again soon!",
        "Ah it's okay, see you soon and looking forward to hearing about how you completed your habit.",
        """
        🔨 Crossable team action:
        Also, congrats on completing a week of Crossable. Give yourselves a pat on the back, a self-hug, or even a high-five and share your new avatars with each other in this channel!
        """
      ),
      new_thirty_day_dialog_msg(
        {2, 1},
        "Hey there! It’s been a whole week since you started your new habit :eyes: Did you get a chance to do your habit over the weekend? React 👍 for Yes and ❌ for No.",
        "Congratulations! Great to have you on the team champ.",
        "Don't worry, I'm sure you've had a hard day. Try and schedule some time for tomorrow for your habit."
      ),
      new_thirty_day_dialog_msg(
        {2, 2},
        "Good morning :) If you got your habit done yesterday, react 👍 If not, react ❌.",
        "Well done friend. You're a hero!",
        "We all fall short sometimes. It happens. What defines us is our ability to come back."
      ),
      new_thirty_day_dialog_msg(
        {2, 3},
        "Hey team! How did it go yesterday? React 👍 if you did your habit and ❌ if not.",
        "Awesome work buddy! Keep it up.",
        "Not to worry, if you feel you need some support, reach out to a human member of the team on the #ask-the-team."
      ),
      new_thirty_day_dialog_msg(
        {2, 4},
        "Hi folks, How did your habit go yesterday? React 👍 if you did your habit and ❌ if not.",
        "You're a warrior - keep up the great work!",
        "That's okay. Hopefully it will be easier to find the time and motivation tomorrow.",
        """
        😇 It’s that time of the week again where I share a fun fact (I’m quirky like that). Did you know that exercising right before bed won’t make you sleep better, but a full night’s sleep will help you exercise better the next day? For the best workout, try exercising earlier in the day and drinking plenty of water before and during.
        https://www.goodreads.com/book/show/34466963-why-we-sleep
        """
      ),
      new_thirty_day_dialog_msg(
        {2, 5},
        "Howdy! If you completed your habit yesterday, react 👍, if not, react ❌.",
        "This is too easy for you! Maybe we need to increase the difficult settings!",
        "That sucks. No worries though and let the Crossable team know if you need any support on the #ask-the-team channel.",
        "🔨12 days into your new habit! Have you noticed any changes in your thoughts or actions throughout the day?"
      ),
      new_thirty_day_dialog_msg(
        {2, 6},
        "What's up? Did you complete your habit?",
        "You make me so proud. I'm going to start running my pride protocol!",
        "Ah no worries. Visualize doing it tomorrow and how great it will feel to complete it tomorrow."
      ),
      new_thirty_day_dialog_msg(
        {2, 7},
        "You know the drill.",
        "Excellent work my friend - see you again soon!",
        "Ah it's okay, see you soon and looking forward to hearing about how you completed your habit."
      ),
      new_thirty_day_dialog_msg(
        {3, 1},
        " Hey team! It’s been two weeks since you started your new habit 🙌. Let’s keep up the momentum this week. Did you get a chance to do your habit over the weekend? React 👍 for Yes and ❌ for No.",
        "Congratulations! Great to have you on the team champ.",
        "Don't worry, I'm sure you've had a hard day. Try and schedule some time for tomorrow for your habit."
      ),
      new_thirty_day_dialog_msg(
        {3, 2},
        """
        Hi folks, If you got your habit done yesterday, react 👍, If not, react ❌.
        Congrats again on your new avatar upgrades. Feel free to flex your new avatars with each other in this channel!
        """,
        "Well done friend. You're a hero!",
        "We all fall short sometimes. It happens. What defines us is our ability to come back."
      ),
      new_thirty_day_dialog_msg(
        {3, 3},
        "Good morning :) How did it go yesterday? React 👍 if you did your habit and ❌ if not.",
        "Awesome work buddy! Keep it up.",
        "Not to worry, if you feel you need some support, reach out to a human member of the team on the #ask-the-team."
      ),
      new_thirty_day_dialog_msg(
        {3, 4},
        """
        Hiya!
        Speaking healthy habits, were you able to do yours yesterday? React 👍 for Yes and ❌ for No.
        """,
        "You're a warrior - keep up the great work!",
        "That's okay. Hopefully it will be easier to find the time and motivation tomorrow.",
        """
        😇 CrossBot here with your weekly health factoid: did you know that cooler temperatures make you more sleepy? This is why it it is hard to sleep on a super hot night. Our body is best attuned to sleep with a surrounding temp of 65* F/18*C. Conversely, taking a warm shower or washing your face with warm water will wake you up more naturally than cold water.
        """
      ),
      new_thirty_day_dialog_msg(
        {3, 5},
        """
        Hey there, how’s it going? 19 days and going strong 💪. React 👍 if you did your habit yesterday and ❌ if not.
        If you haven’t taken a rest day yet, consider taking one of these weekend days off! See you Monday ;)
        """,
        "This is too easy for you! Maybe we need to increase the difficult settings! ",
        "That sucks. No worries though and let the Crossable team know if you need any support on the #ask-the-team channel."
      ),
      new_thirty_day_dialog_msg(
        {3, 6},
        "What's up? Did you complete your habit? ",
        "You make me so proud. I'm going to start running my pride protocol! ",
        "Ah no worries. Visualize doing it tomorrow and how great it will feel to complete it tomorrow. "
      ),
      new_thirty_day_dialog_msg(
        {3, 7},
        "You know the drill.",
        "Excellent work my friend - see you again soon! ",
        "Ah it's okay, see you soon and looking forward to hearing about how you completed your habit. "
      ),
      new_thirty_day_dialog_msg(
        {4, 1},
        """
        Good morning! One more week and you will have completed 30 days of a new habit! How cool is that? The Crossable team will be hosting a graduation show and tell, so start thinking of what you want to share in your presentation!
        Did you get a chance to do your habit over the weekend? React 👍 for Yes and ❌ for No.
        """,
        "Congratulations! Great to have you on the team champ.",
        "Don't worry, I'm sure you've had a hard day. Try and schedule some time for tomorrow for your habit."
      ),
      new_thirty_day_dialog_msg(
        {4, 2},
        """
        Hiya! If you got your habit done yesterday, react 👍. If not, react ❌.
        Congrats again on your new avatar upgrades. Feel free to flaunt your new avatars with each other in this channel, or keep it a surprise until graduation!
        """,
        "Well done friend. You're a hero!",
        "We all fall short sometimes. It happens. What defines us is our ability to come back."
      ),
      new_thirty_day_dialog_msg(
        {4, 3},
        "Hi folks, How did it go yesterday? React 👍 if you did your habit and ❌ if not. You are so close!",
        "Awesome work buddy! Keep it up.",
        "Not to worry, if you feel you need some support, reach out to a human member of the team on the #ask-the-team."
      ),
      new_thirty_day_dialog_msg(
        {4, 4},
        """
        Hey team, random tidbit of the week: we learn best through positive reinforcement, not punishment. In practice that means celebrate your wins and plan for future wins by learning from your losses. This is the Crossable philosophy 😇.
        By the way, how did your habit go yesterday? React 👍 if you did your habit and ❌ if not.
        """,
        "You're a warrior - keep up the great work! ",
        "That's okay. Hopefully it will be easier to find the time and motivation tomorrow."
      ),
      new_thirty_day_dialog_msg(
        {4, 5},
        "Hey there! One more weekend before your 30 days is up! React 👍 if you did your habit yesterday and ❌ if not. I’m proud of ya 😭. Let’s finish strong! See you Monday.",
        "This is too easy for you! Maybe we need to increase the difficult settings! ",
        "That sucks. No worries though and let the Crossable team know if you need any support on the #ask-the-team channel."
      ),
      new_thirty_day_dialog_msg(
        {4, 6},
        "What's up? We're almost there! Did you complete your habit?",
        "You make me so proud. I'm going to start running my pride protocol! ",
        "Ah no worries. Visualise doing it tomorrow and how great it will feel to complete it tomorrow. "
      ),
      new_thirty_day_dialog_msg(
        {4, 7},
        "Final stretch! You know the drill.",
        "Excellent work my friend - we made it to the very end of 30 days!",
        " There's always more after this!"
      )
    ]
  end
end
