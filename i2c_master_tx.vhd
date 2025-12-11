library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity i2c_master_tx is
    port (
        clk        : in  std_logic;
        rst        : in  std_logic;
        start      : in  std_logic;
        slave_addr : in  std_logic_vector(6 downto 0);
        data_in    : in  std_logic_vector(7 downto 0);
        busy       : out std_logic;
        sda        : inout std_logic;
        scl        : out std_logic
    );
end entity;

architecture rtl of i2c_master_tx is

    type state_type is (
        IDLE, START_BIT,
        SEND_ADDR, SEND_DATA,
        STOP_BIT, DONE
    );

    signal state : state_type := IDLE;
    signal bit_cnt : integer range 0 to 7 := 0;
    signal sda_out : std_logic := '1';
    signal scl_reg : std_logic := '1';

begin

    sda <= sda_out;     -- open drain simplified
    scl <= scl_reg;

    process(clk, rst)
    begin
        if rst = '1' then
            state <= IDLE;
            sda_out <= '1';
            scl_reg <= '1';
            busy <= '0';
            bit_cnt <= 0;

        elsif rising_edge(clk) then

            case state is

                when IDLE =>
                    busy <= '0';
                    sda_out <= '1';
                    scl_reg <= '1';
                    if start = '1' then
                        busy <= '1';
                        state <= START_BIT;
                    end if;

                when START_BIT =>
                    sda_out <= '0'; -- START
                    scl_reg <= '1';
                    bit_cnt <= 7;
                    state <= SEND_ADDR;

                when SEND_ADDR =>
                    scl_reg <= '0';
                    sda_out <= slave_addr(bit_cnt);
                    scl_reg <= '1';
                    if bit_cnt = 0 then
                        bit_cnt <= 7;
                        state <= SEND_DATA;
                    else
                        bit_cnt <= bit_cnt - 1;
                    end if;

                when SEND_DATA =>
                    scl_reg <= '0';
                    sda_out <= data_in(bit_cnt);
                    scl_reg <= '1';
                    if bit_cnt = 0 then
                        state <= STOP_BIT;
                    else
                        bit_cnt <= bit_cnt - 1;
                    end if;

                when STOP_BIT =>
                    scl_reg <= '1';
                    sda_out <= '1';
                    state <= DONE;

                when DONE =>
                    busy <= '0';
                    state <= IDLE;

            end case;
        end if;
    end process;

end rtl;
