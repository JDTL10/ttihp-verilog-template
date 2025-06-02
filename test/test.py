@cocotb.test()
async def test_project(dut):
    dut._log.info("Start")

    clock = Clock(dut.clk, 10, units="us")
    cocotb.start_soon(clock.start())

    # Reset
    dut.ena.value = 1
    dut.ui_in.value = 0
    dut.rst_n.value = 0
    await ClockCycles(dut.clk, 10)
    dut.rst_n.value = 1

    # Example test: A=5, B=3, OpSel=00 (sum)
    A = 5  # 4'b0101
    B = 3  # 4'b0011
    OpSel = 0b00  # inside A[1:0]
    ui_in_value = (B << 4) | A  # pack as [B][A]
    dut.ui_in.value = ui_in_value

    await ClockCycles(dut.clk, 1)

    expected_result = (A + B) & 0b1111  # only 4 LSB
    expected_output = expected_result

    assert dut.uo_out.value.integer & 0b1111 == expected_output, f"Expected {expected_output}, got {dut.uo_out.value.integer & 0b1111}"
