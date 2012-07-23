require_relative 'helpers'

class QuickRun < IWNGTest

  N_TASKS = 5000

  def setup
    super
    client.codes.create code_bundle(:name => 'test',
                                    :exec => File.join(File.dirname(__FILE__), 'hello.rb'))
  end

  def test_quick_run2
    task_ids = []
    N_TASKS.times do
      task_ids << client.tasks.create('test').id
    end

    task_ids.each do |id|
      task = client.tasks.wait_for(id)
      assert_equal 'complete', task.status
      assert_equal "hello\n", client.tasks.log(id)
    end
  end

end