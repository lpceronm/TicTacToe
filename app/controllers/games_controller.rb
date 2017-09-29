class GamesController < ApplicationController
  # before_action :set_game, only: [:show, :edit, :update, :destroy]
  #
  # # GET /games
  # # GET /games.json
  # def index
  #   @games = Game.all
  # end
  #
  # # GET /games/1
  # # GET /games/1.json
  # def show
  # end
  #
  # # GET /games/new
  # def new
  #   @game = Game.new
  # end
  #
  # # GET /games/1/edit
  # def edit
  # end
  #
  # # POST /games
  # # POST /games.json
  # def create
  #   @game = Game.new(game_params)
  #
  #   respond_to do |format|
  #     if @game.save
  #       format.html { redirect_to @game, notice: 'Game was successfully created.' }
  #       format.json { render :show, status: :created, location: @game }
  #     else
  #       format.html { render :new }
  #       format.json { render json: @game.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end
  #
  # # PATCH/PUT /games/1
  # # PATCH/PUT /games/1.json
  # def update
  #   respond_to do |format|
  #     if @game.update(game_params)
  #       format.html { redirect_to @game, notice: 'Game was successfully updated.' }
  #       format.json { render :show, status: :ok, location: @game }
  #     else
  #       format.html { render :edit }
  #       format.json { render json: @game.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end
  #
  # # DELETE /games/1
  # # DELETE /games/1.json
  # def destroy
  #   @game.destroy
  #   respond_to do |format|
  #     format.html { redirect_to games_url, notice: 'Game was successfully destroyed.' }
  #     format.json { head :no_content }
  #   end
  # end
  #
  def initialize
    @game_state = @initial_game_state = GameTree.new.generate
  end

  def turn
    puts @game_state.current_player
    if @game_state.final_state?
      describe_final_game_state
      puts "Play again? y/n"
      answer = params[:answer]
      if answer.downcase.strip == 'y'
        @game_state = @initial_game_state
        # turn
      else
        exit
      end
    end

    if @game_state.current_player == 'X'
      puts "\n==============="
      @game_state = @game_state.next_move
      puts "X's move:"
      render_board
      # turn
    else
      get_human_move
      puts "The result of your move:"
      render_board
      puts ""
      # turn
    end
  end

  def render_board
    output = ""
    0.upto(8) do |position|
      output << " #{@game_state.board[position] || position} "
      case position % 3
      when 0, 1 then output << "|"
      when 2 then output << "\n-----------\n" unless position == 8
      end
    end
    puts output
  end
$begin = false
  def get_human_move
    puts "Enter square # to place your 'O' in:"

      if $begin
        position = params[:game].to_s
      else
        position = '4'
        $begin = true
      end
    move = @game_state.moves.find{ |game_state| game_state.board[position.to_i] == 'O' }

    if move
      @game_state = move
    else
      puts "That's not a valid move"
      get_human_move
    end
  end

  def describe_final_game_state
    if @game_state.draw?
      puts "It was a draw!"
    elsif @game_state.winner == 'X'
      puts "X won!"
    else
      puts "O won!"
    end
    redirect_to 'root'
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_game
      @game = Game.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def game_params
      params.permit(:game,:answer)
    end
end
