:-use_module(library(lists)).
:-use_module(library(system)).
:-use_module(library(random)).


:-include('interface/board_display.pl').
:-include('interface/labels_display.pl').
:-include('interface/main_menu_display.pl').
:-include('interface/main_menu_choose.pl').

:-include('logic/ask_for_input.pl').
:-include('logic/choose_moves_PC.pl').
:-include('logic/loop_game.pl').
:-include('logic/player_capture.pl').
:-include('logic/player_king_move.pl').
:-include('logic/player_man_move.pl').
:-include('logic/player_move.pl').
:-include('logic/verifications.pl').
:-include('logic/player_man_capture.pl').

:-include('utils/init.pl').
:-include('utils/map_positions.pl').
:-include('utils/aux_func.pl').

startExample :- chooseGameMode.
