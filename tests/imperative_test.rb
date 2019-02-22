require('minitest/autorun')
require('conjugator/imperative')

class TestConjugator < MiniTest::Test
  [
    # All the base verbs used to show verb classes paradigms 
    %w(nesou nes nes),
    %w(čtou čt čti),
    %w(pečou peč peč),
    %w(pekou pek peč),
    %w(třou tř tři),
    %w(berou ber ber),
    %w(mažou maž maž),
    %w(tisknou tiskn tiskni),
    %w(minou min miň),
    %w(začnou začn začni),
    %w(kryjí kryj kryj),
    %w(prosí pros pros),
    %w(čistí čist čisti),
    %w(trpí trp trp),
    %w(sázejí sázej sázej),
    %w(dělají dělaj dělej)
  ].each do |args|
    define_method("test_stem_#{args[0]}") do
      assert_equal(args[1], Conjugator::Imperative::strip_ending(args[0]))
    end
    
    define_method("test_imperative_#{args[0]}") do
      assert_equal(args[2], Conjugator::Imperative::make_imperative(args[1]))
    end
  end
end
