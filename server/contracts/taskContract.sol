// SPDX-License-Identifier: UNLICENSED
pragma solidity ^ "0.8.18"

// Uncomment this line to use console.log
import "hardhat/console.sol";

contract TaskContract {
    event AddTask(address sender, uint256 taskId);
    event DeleteTask(uint256 taskId, bool isDeleted);

    struct taskStruct {
        string taskDescr;
        uint256 taskId;
        bool isDeleted;
    }

    // variable size name
    taskStruct[] private TaskArr;

    // mapping : taskid to address so it will let us know which user adds this particular task
    mapping(uint256 => address) taskOwner;

    function addTask(string memory text) external {
        uint256 taskId = TaskArr.length;
        // taskStruct memory task = taskStruct({taskDescr: text, taskId: taskId, isDeleted: false});
        // TaskArr.push(task);
        TaskArr.push(
            taskStruct({taskDescr: text, taskId: taskId, isDeleted: false})
        );

        taskOwner[taskId] = msg.sender;
        emit AddTask(msg.sender, taskId);
    }

    function deleteTask(uint256 id) external {
        if (taskOwner[id] == msg.sender) {
            TaskArr[id].isDeleted = true;
            // bool delete = true;
            emit DeleteTask(id, true);
        }
    }

    function getTask() external view returns (taskStruct[] memory, uint256) {

        //get my tasks
        taskStruct[] memory temporary = new taskStruct[](TaskArr.length);
        uint256 length = TaskArr.length;
        uint256 count = 0;
        for (uint256 i = 0; i < TaskArr.length; i++) {
            if (taskOwner[i] == msg.sender && !TaskArr[i].isDeleted) {
                temporary[count] = TaskArr[i];
                count++;
            }
        }
        return (temporary, length);
    }
}
