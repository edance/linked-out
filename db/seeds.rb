terms = ['ceo',
         'cto',
         'software engineer',
         'san francisco',
         'tom',
         'apartment list',
         'cribspot',
         'a2cribs',
         'vp of engineering',
         'detroit']

terms.map { |x| SearchTerm.create(name: x) }
