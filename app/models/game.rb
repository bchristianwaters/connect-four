class Game < ApplicationRecord
  has_many :messages, dependent: :destroy
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
end
