require 'test_helper'

class QuestionTest < ActiveSupport::TestCase

  test 'should not save empty question' do
    question = Question.new

    assert_not question.save
  end

  test 'should save question with all attributes' do
    question = Question.new(area: 'something',year: 2008, enunciation: 'something', number: 001, reference: 'something', image: 'something')
    create_alternatives(question)

    assert question.save
  end

  test 'should not save question without number' do
    question = Question.new(area: 'something',year: 2008, enunciation: 'something', reference: 'something')
    create_alternatives(question)

    assert_not question.save
  end

  test 'should not save question without area' do
    question = Question.new(number: 001, year: 2008, enunciation: 'something', reference: 'something')
    create_alternatives(question)

    assert_not question.save
  end

  test 'should not save question without year' do
    question = Question.new(number: 001, area: 'something', enunciation: 'something', reference: 'something')
    create_alternatives(question)

    assert_not question.save
  end

  test 'should not save question without enunciation' do
    question = Question.new(number: 001, year: 2008, area: 'something', reference: 'something')
    create_alternatives(question)

    assert_not question.save
  end

  test 'should save question with no image' do
    question = Question.new(area: 'something',year: 2008, enunciation: 'something', number: 001, reference: 'something')
    create_alternatives(question)

    assert question.save
  end

  test 'should save question with no reference' do
    question = Question.new(area: 'something',year: 2008, enunciation: 'something', number: 001, image: 'something')
    create_alternatives(question)

    assert question.save
  end

  test 'should not save question that year has more than four digits' do
    question = Question.new(area: 'something', year: 12345, enunciation: 'something', number: 001)
    create_alternatives(question)

    assert_not question.save
  end

  test 'should not save question that number has more that three digits' do
    question = Question.new(area: 'something', year: 2008, enunciation: 'something', number: 1234)
    create_alternatives(question)

    assert_not question.save
  end

  test 'should not save question with no alternatives' do
    question = Question.new(area: 'something',year: 2008, enunciation: 'something', number: 001, reference: 'something', image: 'something')
    5.times{question.alternatives.build}

    assert_not question.save
  end

  test 'should not save question that a alternative letter has more that one character' do
    question = Question.new(area: 'something',year: 2008, enunciation: 'something', number: 001, reference: 'something', image: 'something')
    create_alternatives(question)
    question.alternatives[0].letter = 'ab'

    assert_not question.save
  end

  test 'should not save question that alternatives hash is blank' do
    question = Question.new(area: 'something',year: 2008, enunciation: 'something', number: 001, reference: 'something', image: 'something')

    assert_not question.save
  end

  private

    def create_alternatives(question)
      ch = '@'

      5.times{question.alternatives.build}
        question.alternatives.each do |alt|
          alt.letter = ch.next!
          alt.description = 'something'
      end
    end

end