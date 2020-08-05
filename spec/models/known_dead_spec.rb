RSpec.describe KnownDead do
  it { should belong_to(:user) }
  it { should belong_to(:relationship) }
  it { should belong_to(:sitterform) }
end
