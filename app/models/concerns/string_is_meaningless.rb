class String
  # проверка на бессмысленность текста
  def meaningless?
    metric(self) > MAX_VALID_METRIC
  end

  private

  MAX_VALID_METRIC = 17.0

  # min_count: Минимальное число символов из заданного класса, чтобы начать считать метрику (-1 - всегда считаем)
  # min_relative_count: Минимальное относительное число символов, чтобы начать считать метрику
  # mentic_factor: Коэффициент метрики, для класса символов

  CHAR_TYPES = {
    chars: [
      'ОоАаЕеИи', 'НнТтРрСс', 'ЛлВв', 'КкПпМмУуДдЯяЫы', 'БбГгЁёЖжЗзЙйФфХхЦцЧчШшЩщЪъЬьЭэЮю',
      'EeTt', 'AaOoNnRr', 'IiSsHhDd', 'LlFfCcMmUu', 'BbGgJjKkPpQqVvWwXxYyZz',
      '1234567890', '~`.,:;!@$%^*(-=_+?[]/\"', ')', ' '
    ],
    mentic_factor: [
      1.0, 1.0, 1.0, 1.0, 1.0,
      1.0, 1.0, 1.0, 1.0, 1.0,
      2.0, 3.0, 2.0, 1.5
      ],
    min_relative_count: [
      0.37, 0.25, 0.17, 0.14, 0.09,
      0.39, 0.24, 0.20, 0.10, 0.08,
      0.20, 0.11, 0.20, 0.25
    ],
    min_count: [
      4, 4, 4, 4, 4,
      4, 4, 4, 4, 4,
      4, 4, 4, 4
    ]
  }.freeze

  def metric(text)
    result = 0.0
    chars_counts = {} # символ => число появлений
    text.each_char do |ch| # считаем число появления символов
      chars_counts[ch] ||= 0
      chars_counts[ch] += 1
    end
    chars_counts.each do |char, char_count|
      it = -1 # порядковый номер записи в таблице
      CHAR_TYPES[:chars].each_with_index do |chars, index| # ищем в таблице
        if chars.include?(char)
          it = index
          break
        end
      end
      next if it == -1 # символ не найден
      next if CHAR_TYPES[:min_count][it] != -1 && char_count <= CHAR_TYPES[:min_count][it] #
      next if char_count / text.length.to_f <= CHAR_TYPES[:min_relative_count][it] # вычисляем коэфициэнт пояления симовола
      result += char_count * CHAR_TYPES[:mentic_factor][it]
    end
    result
  end

end	