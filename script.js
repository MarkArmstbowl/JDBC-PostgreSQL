
function add_meeting(button) {
                
    let thElement = button.closest('th');
    let previous = thElement.previousElementSibling;

    let newSection = document.createElement('input');
    let newValue = previous.firstElementChild.value;

    let mandatory = thElement.nextElementSibling;


    //For Section Type
    let newLine = document.createElement('br');
    let newSectionType = document.createElement('input');

    newSectionType.name = 'meeting_type';
    newSectionType.placeholder = 'Ex: LE or DI...';
    newSection.value = '';


    thElement.appendChild(newLine);
    thElement.appendChild(newSectionType);


    //For Mandatory
    let new_mandatory = document.createElement('input');
    let newLine1 = document.createElement('br');
    new_mandatory.value = '';
    new_mandatory.name = 'mandatory';
    new_mandatory.placeholder = 'Ex: Yes or No...';

    mandatory.appendChild(newLine1);
    mandatory.appendChild(new_mandatory);

    //For Days
    let days = mandatory.nextElementSibling;
    let newLine2 = document.createElement('br');
    let new_days = document.createElement('input');
    new_days.value = '';
    new_days.name = 'days';
    new_days.placeholder = 'Ex: MW...TTh..';

    days.appendChild(newLine2);
    days.appendChild(new_days);

    //For Time
    let time = days.nextElementSibling;
    let newLine3 = document.createElement('br');
    let new_time = document.createElement('input');
    new_time.value = '';
    new_time.name = 'start_time';
    new_time.placeholder = 'Ex: 11:00 AM';

    time.appendChild(newLine3);
    time.appendChild(new_time);

    let time1 = time.nextElementSibling;
    let newLine33 = document.createElement('br');
    let new_time1 = document.createElement('input');
    new_time1.value = '';
    new_time1.name = 'end_time';
    new_time1.placeholder = 'Ex: 05:00 PM';

    time1.appendChild(newLine33);
    time1.appendChild(new_time1);


    //For Building
    let building = time1.nextElementSibling;
    let newLine4 = document.createElement('br');
    let new_building = document.createElement('input');
    new_building.value = '';
    new_building.name = 'building';
    new_building.placeholder = 'Ex: WLH...';

    building.appendChild(newLine4);
    building.appendChild(new_building);

    //For Room
    let room = building.nextElementSibling;
    let newLine5 = document.createElement('br');
    let new_room = document.createElement('input');
    new_room.value = '';
    new_room.name = 'room';
    new_room.placeholder = 'Ex: M2203..';

    room.appendChild(newLine5);
    room.appendChild(new_room);



}
function add_Review() {
    let container = document.getElementById('reviews-for-classes');
    let newList = document.createElement('tr');

    newList.innerHTML = `
        <th><input value="" name="review-dates" placeholder="Ex: 05/14/2024..."></th>
        <th><input value="" name="review_start_time" placeholder="Ex: 11:00 AM"></th>
        <th><input value="" name="review_end_time" placeholder="Ex: 05:00 PM"></th>
        <th><input value="" name="review-building" placeholder="Ex: WLH..."></th>
        <th><input value="" name="review-room" placeholder="Ex: M2203..."></th>
    `;

    container.appendChild(newList);
      
}




