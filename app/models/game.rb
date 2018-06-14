class Game < ApplicationRecord
  has_many :messages, dependent: :destroy
    #this function finds the current height - 1 of a column
    def height(column)
        return (self.board[6*column+5] == "e") ? self.board[6*column..6*column+5].index("e") : 6
    end
        
    #this function places down the tile of whoever's turn it is
    def place(column)
        # making sure there is room in the column and that the game isn't over
        if self.board[6*column+5] == "e" && self.state == "In progress"
            #adding the piece and updating attributes
            self.board[self.board[6*column..6*column+5].index("e")+6*column] = self.turn[0]
            self.turn == "red" ? self.turn = "black" : self.turn = "red"
            self.moves = self.moves + 1
            # updating the state of the game if applicable
            if self.winner()
                self.winner() == "r" ? self.state = "red wins!" : self.state = "black wins!"
            elsif self.moves == 42
                self.state = "tie"
            end
            self.save
        end
        self.board
    end
    
    # Checks to see if there is a winner. If there is a winner, then it returns 
    # the winner. If there isn't, then it return nil.
    def winner
        # checking columns for a winner
        for i in 0..6
            for j in 0..2
                array = [self.board[6*i+j], self.board[6*i+j+1], self.board[6*i+j+2], self.board[6*i+j+3]]
                if self.board[6*i+j] != "e" && array.all? {|x| x == self.board[6*i+j]}
                    return self.board[6*i+j]
                end
            end
        end
        # checking rows for a winner
        for j in 0..5
            for i in 0..3
                array = [self.board[6*i+j], self.board[6*i+j+6], self.board[6*i+j+12], self.board[6*i+j+18]]
                if self.board[6*i+j] != "e" && array.all? {|x| x == self.board[6*i+j]}
                    return self.board[6*i+j]
                end    
            end
        end
        #checking rising diagonal
        for i in 0..3
            for j in 0..2
                array = [self.board[6*i+j], self.board[6*i+j+7], self.board[6*i+j+14], self.board[6*i+j+21]]
                if self.board[6*i+j] != "e" && array.all? {|x| x == self.board[6*i+j]}
                    return self.board[6*i+j]
                end    
            end
        end
        #checking falling diagonal
        for i in 0..3
            for j in 3..5
                array = [self.board[6*i+j], self.board[6*i+j+5], self.board[6*i+j+10], self.board[6*i+j+15]]
                if self.board[6*i+j] != "e" && array.all? {|x| x == self.board[6*i+j]}
                    return self.board[6*i+j]
                end              
            end
        end
        return nil
    end
    def easy
        max_column = "not defined"
        max_value = 0
        for i in 0..6
            max_column = i if ((max_column == "not defined") && (self.board[6*i+5] == "e"))
            if self.board[6*i] == "e"
                if priority(6*i)>max_value
                    max_column = i
                    max_value = priority(6*i)
                end
            else
                for j in 1..5
                    if self.board[6*i+j] == "e" && self.board[6*i+j-1] != "e"
                        if priority(6*i+j)>max_value
                            max_column = i
                            max_value = priority(6*i+j)
                        end
                    end
                end
            end
        end
        if max_value<=0
            possible = [];
            for i in 0..6
                x=4-((i-3).abs)
                x.times do |j|
                    possible.push(i) if self.board[6*i+5] == "e" 
                end
            end
            place(possible.sample)
        else
            place(max_column)
        end
    end
    def medium
        max_column = "not defined"
        max_value = 0
        for i in 0..6
            max_column = i if ((max_column == "not defined") && (self.board[6*i+5] == "e"))
            x = 4-((i-3).abs)
            x = priority2(i) if priority2(i) > x
            if self.board[6*i] == "e"
                x = priority(6*i) if priority(6*i) > x
                x = priority3(6*i) if priority3(6*i) < 0
                if x > max_value
                    max_column = i
                    max_value = x
                end
            else
                for j in 1..5
                    if self.board[6*i+j] == "e" && self.board[6*i+j-1] != "e"
                        x = priority(6*i+j) if priority(6*i+j) > x
                        x = priority3(6*i+j) if priority3(6*i+j) < 0
                        if x > max_value
                            max_column = i
                            max_value = x
                        end
                    end
                end
            end
        end
        place(max_column)
    end
    def difficult
        max_column = "not defined"
        max_value = -9999999
        for i in 0..6
            max_column = i if ((max_column == "not defined") && (self.board[6*i+5] == "e"))
            x = 4-((i-3).abs) + priority2(i)
            if self.board[6*i] == "e"
                x += priority(6*i) + priority3(6*i) + priority4(6*i) + priority5(6*i) + priority6(6*i)
                if x > max_value
                    max_column = i
                    max_value = x
                end
            else
                for j in 1..5
                    if self.board[6*i+j] == "e" && self.board[6*i+j-1] != "e"
                        x += priority(6*i+j) + priority3(6*i+j) + priority4(6*i+j) + priority5(6*i+j) + priority6(6*i+j)
                        if x > max_value
                            max_column = i
                            max_value = x
                        end
                    end
                end
            end
        end
        place(max_column)
    end
    def priority(number)
        self.board[number] = "b"
        if self.winner
           self.board[number] = "e"
           return 2000
        end
        self.board[number] = "r"
        if self.winner
            self.board[number] = "e"
            return 1000
        end
        self.board[number] = "e"
        return 0
    end
    def priority2(i)
        if self.board[6*i] == "e"
            #checking for tile to left
            if i>1 && self.board[6*i-6] == "r" && i<6
                #checking for tile to right
                if i<5 && self.board[6*i+6] == "r" && self.board[6*i+1] == "e" && self.board[6*i-12] == "e"
                    return 800
                #checking for another tile to left    
                elsif i>2 && self.board[6*i-12] == "r" && self.board[6*i-18] == "e"  && self.board[6*i+6] == "e"
                    return 800
                end
            #checking for two tiles to right
            elsif i<4 && i>0 && self.board[6*i+6] == "r" && self.board[6*i+12] == "r" && self.board[6*i+18] == "e" && self.board[6*i-6] == "e" 
                return 800
            end
        end
        return 0
    end
    def priority3(number)
        unless number % 6 == 5
            self.board[number+1] = "r"
            if self.winner
                self.board[number+1] = "e"
                return -800
            end 
            self.board[number+1] = "e"
        end
        return 0
    end
    def priority4(number)
        points_before = 0
        points_after = 0
        for i in 0..6
            for j in 0..5
                if self.board[6*i+j] == "e" 
                    self.board[6*i+j] = "b" 
                    if self.winner
                        points_before += 10+20*((j+1)%2)
                    end
                    self.board[number] = "b"
                    if self.winner
                        points_after += 10+20*(j%2)
                    end
                    self.board[number] = "e"
                    self.board[6*i+j] = "e"
                end
            end
        end
        return points_after - points_before
    end
    def priority5(number)
        epoints_before = 0
        epoints_after = 0
        for i in 0..6
            for j in 0..5
                if self.board[6*i+j] == "e"
                    self.board[6*i+j] = "r"  
                    if self.winner
                        epoints_before += 40*((j+1)%2)
                    end
                    self.board[number] = "r"
                    if self.winner
                        epoints_after += 40*((j+1)%2)
                    end
                    self.board[number] = "e"
                    self.board[6*i+j] = "e"
                end
            end
        end
        return epoints_after-epoints_before
    end
    def priority6(number)
        return 0 if number % 6 == 5
        epoints_before = 0
        epoints_after = 0
        for i in 0..6
            for j in 0..5
                if self.board[6*i+j] == "e" 
                    self.board[6*i+j] = "r"
                    if self.winner
                        epoints_before += 35*((j+1)%2)
                    end
                    self.board[number+1] = "r"
                    if self.winner
                        epoints_after += 35*((j+1)%2)
                    end
                    self.board[number+1] = "e"
                    self.board[6*i+j] = "e"
                end
            end
        end
        return epoints_before-epoints_after
    end
end
