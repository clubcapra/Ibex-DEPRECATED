package ca.etsmtl.capra;

import org.ros.concurrent.CancellableLoop;
import org.ros.namespace.GraphName;
import org.ros.node.AbstractNodeMain;
import org.ros.node.ConnectedNode;
import org.ros.node.NodeMain;
import org.ros.node.topic.Publisher;

public class SmartMotor extends AbstractNodeMain
{
	@Override
	public GraphName getDefaultNodeName()
	{
		return GraphName.of("capra/SmartMotor");
	}

	@Override
	public void onStart(final ConnectedNode connectedNode)
	{
		final Publisher<nav_msgs.Odometry> publisher = connectedNode.newPublisher("/capra/SmartMotor/odom", nav_msgs.Odometry._TYPE);

		connectedNode.executeCancellableLoop(new CancellableLoop()
		{
			@Override
			protected void loop() throws InterruptedException
			{
				nav_msgs.Odometry odom = publisher.newMessage();
				publisher.publish(odom);
				Thread.sleep(1000);
			}
		});
	}
}
