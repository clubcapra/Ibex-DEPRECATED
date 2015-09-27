import rospy
import rospkg
import json
from animatics_smart_motor.srv import SetMotorsSpeed, SetMotorsSpeedRequest, SetMotorsSpeedResponse
import threading

notes = {
    "F0": 0.4,
    "Fs0": 0.425,
    "G0": 0.45,
    "Gs0": 0.475,
    "A1": 0.5,
    "As1": 0.53,
    "B1": 0.56,
    "C1": 0.6,
    "Cs1": 0.635,
    "D1": 0.665,
    "Ds1": 0.7,
    "E1": 0.745,
    "F1": 0.8,
    "Fs1": 0.850,
    "G1": 0.9,
    "Gs1": 0.950,
    "A2": 1.0,
    "As2": 1.06,
    "B2": 1.12,
    "C2": 1.2,
    "Cs2": 1.270,
    "D2": 1.330,
    "Ds2": 1.4,
    "E2": 1.49,
    "F2": 1.6,
    "Fs2": 1.7,
    "G2": 1.8,
    "Gs2": 1.9,
    "A3": 2.0,
    "As3": 2.1,
    "X": 0.0
}

def play_track(motor_number, track):
    global bpm
    set_motors_speed = rospy.ServiceProxy('set_motors_speed', SetMotorsSpeed)

    # Loop through all the notes.
    for note in track:
        speed = notes[note["tone"]]
        duration = note["beat"] / (bpm / 60)

        # Send the command to the motor.
        set_motors_speed(motor_number, speed, rospy.Duration(duration))

        # Sleep for the duration of the note.
        rospy.sleep(duration)

if __name__ == "__main__":
    rospy.init_node('motors_music')
    rospy.wait_for_service("set_motors_speed")
    rospack = rospkg.RosPack()
    path = rospack.get_path('animatics_smart_motor')
    bpm_ratio = rospy.get_param('~bpm_ratio', 1.0)

    # Parse the file.
    song_file = rospy.get_param('~song', "bonnefete.music")
    with open(path + "/music/" + song_file) as file:
        music = json.load(file)
    bpm = music["bpm"] / bpm_ratio
    tracks = [track["content"] for track in music["tracks"]]

    # If there is only one track, copy it for the other motor.
    if len(tracks) == 1:
        tracks.append(tracks[0])

    # Start a thread for each track.
    threads = []
    for index, track in enumerate(tracks):
        thread = threading.Thread(target=play_track, args=(index, track))
        thread.daemon = True
        threads.append(thread)
        thread.start()

    for thread in threads:
        thread.join()

