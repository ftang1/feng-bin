#!/bin/sh
echo function_graph > current_tracer
echo 1 > tracing_enabled;
sleep 1
echo 0 > tracing_enabled;
echo funcgraph-abstime > trace_options
echo funcgraph-proc > trace_options
cat trace > ~/trace.log
