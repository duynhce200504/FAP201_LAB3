library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity lab3 is
    port (
        clk   : in  STD_LOGIC;
        i_sw  : in  STD_LOGIC;
        o_led : out STD_LOGIC
    );
end entity lab3;

architecture rtl of lab3 is
    signal sw_pressed      : STD_LOGIC; 
    
    signal current_sample  : STD_LOGIC := '0';
    signal previous_sample : STD_LOGIC := '0';
    signal led_state       : STD_LOGIC := '0';
    signal release_event   : STD_LOGIC;
begin
    sw_pressed <= not i_sw;

    release_event <= previous_sample and (not current_sample);

    process(clk)
    begin
        if rising_edge(clk) then
            previous_sample <= current_sample;
            current_sample  <= sw_pressed; 
            
            if release_event = '1' then
                led_state <= not led_state;
            end if;
        end if;
    end process;

    o_led <= led_state;
end architecture rtl;