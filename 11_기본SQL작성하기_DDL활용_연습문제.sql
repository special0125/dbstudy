-- 1. 국가(nation) 테이블
create table nation
(  
    nation_code number(3),
    nation_name varchar2(30),
    nation_prev_rank number,
    nation_curr_rank number,
    nation_parti_person number,
    nation_parti_event number
);

-- 2. 종목(event) 테이블
create table event
(
    event_code number(5),
    event_name varchar2(30),
    event_info varchar2(1000),
    event_first_year number(4)
);

-- 3. 선수(player) 테이블
create table player
(
    player_code number(5),
    nation_code number(3),
    event_code number(5),
    player_name varchar2(30),
    player_age number(3),
    player_rank number
);

-- 4. 일정(schedule) 테이블
create table schedule
(
    nation_code number(3),
    event_code number(5),
    schedule_info varchar2(1000),
    schedule_begin date,
    schedule_end date
);
