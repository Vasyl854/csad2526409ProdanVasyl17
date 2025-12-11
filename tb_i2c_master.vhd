library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_i2c_master is
end tb_i2c_master;

architecture sim of tb_i2c_master is

    signal clk        : std_logic := '0';
    signal rst        : std_logic := '1';

    signal start_tx   : std_logic := '0';
    signal start_rx   : std_logic := '0';

    signal slave_addr : std_logic_vector(6 downto 0) := "1010000";

    signal data_in    : std_logic_vector(7 downto 0) := x"A5";
    signal data_out   : std_logic_vector(7 downto 0);

    signal busy_tx    : std_logic;
    signal busy_rx    : std_logic;

    signal sda_line   : std_logic := '1';
    signal scl_line   : std_logic := '1';

begin

    clk <= not clk after 10 ns;

    -- TX instance
    TX : entity work.i2c_master_tx
        port map (
            clk        => clk,
            rst        => rst,
            start      => start_tx,
            slave_addr => slave_addr,
            data_in    => data_in,
            busy       => busy_tx,
            sda        => sda_line,
            scl        => scl_line
        );

    -- RX instance
    RX : entity work.i2c_master_rx
        port map (
            clk        => clk,
            rst        => rst,
            start      => start_rx,
            slave_addr => slave_addr,
            data_out   => data_out,
            busy       => busy_rx,
            sda        => sda_line,
            scl        => scl_line
        );

    -- Stimulus
    process
    begin
        rst <= '1';
        wait for 50 ns;
        rst <= '0';

        -- Start TX
        start_tx <= '1';
        wait for 20 ns;
        start_tx <= '0';

        wait until busy_tx = '0';
        wait for 200 ns;

        -- Start RX
        start_rx <= '1';
        wait for 20 ns;
        start_rx <= '0';

        wait until busy_rx = '0';
        wait for 200 ns;

        wait;
    end process;

end sim;
