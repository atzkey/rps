class Rps
  DEFAULT_RULES = {
    'rock' => ['scissors'],
    'paper' => ['rock'],
    'scissors' => ['paper'],
  }

  #
  # Rules format:
  #  { 'hand' => ['hands', 'it', 'beats'], ... }
  def initialize(rules)
    @rules = rules
  end
  
  # Checking if `hand` beats the `other_hand`
  #
  # Returns `nil` if a thrown hand is not described
  # in the rules.
  def match(hand, other_hand)
    return nil unless hands.include?(hand) && hands.include?(other_hand)

    if hand === other_hand
      :tie
    elsif @rules[hand].include?(other_hand)
      :win
    else
      :loss
    end
  end

  def hands
    @rules.keys
  end
end