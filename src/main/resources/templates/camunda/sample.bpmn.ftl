<?xml version="1.0" encoding="UTF-8"?>
<bpmn:definitions xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
                  xmlns:bpmn="http://www.omg.org/spec/BPMN/20100524/MODEL"
                  xmlns:bpmndi="http://www.omg.org/spec/BPMN/20100524/DI"
                  xmlns:dc="http://www.omg.org/spec/DD/20100524/DC"
                  id="Definitions_${aggregateName}"
                  targetNamespace="http://camunda.org/schema/1.0/bpmn">

    <bpmn:process id="${serviceName}-process" name="${aggregateName} Process" isExecutable="true">
        <bpmn:startEvent id="StartEvent_1" name="Start" />
        <bpmn:serviceTask id="Task_1" name="${aggregateName} Task" camunda:type="external" camunda:topic="${serviceName}-task" />
        <bpmn:endEvent id="EndEvent_1" name="End" />
    </bpmn:process>

    <bpmndi:BPMNDiagram id="BPMNDiagram_${aggregateName}">
        <bpmndi:BPMNPlane id="BPMNPlane_${aggregateName}" bpmnElement="${serviceName}-process"/>
    </bpmndi:BPMNDiagram>
</bpmn:definitions>
