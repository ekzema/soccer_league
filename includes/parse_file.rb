class ParseFile
  def parse
    teams = File.readlines('./teams.txt', chomp: true)
    return get_winners(teams) unless teams.empty?
    puts 'Error parse file'
  end

  private

  def get_winners(teams)
    result = {}
    teams.each do |team|
      team_arr = team.split(',').map(&:strip)
      item1 =  team_arr[0].split(' ')
      item2 = team_arr[1].split(' ')
      item1_total = item1.pop
      item2_total = item2.pop
      item1 = item1.join(' ')
      item2 = item2.join(' ')
      result[item1] = 0 unless result.key?(item1)
      result[item2] = 0 unless result.key?(item2)
      result[item1] += 3 if item1_total > item2_total
      result[item1] += 1 if item1_total == item2_total
      result[item2] += 3 if item2_total > item1_total
      result[item2] += 1 if item2_total == item1_total
    end
    sort_by(result)
  end

  def sort_by(hash)
    items = hash.sort_by { |name, total| total }
    print_in_terminal(items.reverse)
  end

  def print_in_terminal(items)
    items.each do |item|
      puts "#{item[0]} #{item[1]} pts"
    end
  end
end