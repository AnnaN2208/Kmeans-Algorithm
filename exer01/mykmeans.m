%{
%Ntagiou Anna
%AEM:432
%}
function [ClusterCenters, IDC] = mykmeans(Data,K)

%{
%Initialization of variables
%}
[m, n]=size(Data);                                                          %Size of Data matrix. The m variable is the number of points
IDC = zeros(m,4);                               
IDC(:,[1:2]) = Data;                                                        %Initialization of IDC[1:2] with the coordinates of the points
FlagStopLoop=0;                                                             %This Flag helps for the while loop to stop. If it is 1, the loop will stop.
CounterLoop=0;                                                              %Variable for loop counting
ClusterCenters=zeros(K,2);
InitialClusters=randperm(m,K);                                              %Variable with K random numbers from 1 to m.

%{
%First initialization of ClusterCenters
%}
for i=1:K
    ClusterCenters(i,1) = Data(InitialClusters(i),1);
    ClusterCenters(i,2) = Data(InitialClusters(i),2);
end

while FlagStopLoop==0
    
%{
%Calculation of euclidean distance of every point from every center
%}
Distances=zeros(K,m);                                                       %Initialization of matrix Distances Kxm
for z=1:m
    for i=1:K                                                               
        V=0;
        for a=1:2
            V=V+(Data(z,a) - ClusterCenters(i,a))^2;                        %Calculation of V=(y1-x1)^2+(y2-x2)^2
        end
        Distances(i,z) = sqrt(V);                                           %Calculation of square root of V
    end
end

%{
%Calculation of min of distances
%}
[Min,Group] = min(Distances);                                               
IDC(:,3)=Min;
IDC(:,4)=Group;

%{
%Plot of the points and the center of every cluster
%}
figure(2);
for i = 1:K
    x = 0;
    y = 0;
    for j = 1:m
        if IDC(j,4) == i
            x(end+1) = IDC(j,1);
            y(end+1) = IDC(j,2);
        end
    end
    
    scatter(x(:),y(:),300,[rand rand rand],'.');                            %Plot of the points
    hold on;
end
legend('-DynamicLegend');
scatter(ClusterCenters(:,1),ClusterCenters(:,2),150,'r*');                  %Plot of the centers
hold off;

%{
%Calculation of the new cluster centers
%}
newClusterCenters=zeros(K,2); 
MembersOfGroup=zeros(K);                                                    %Variable for the number of points of each group
for i = 1:K
    SumOfGroupX=0;                                                          %In this variable there is the sum of x coordinate (one group/loop)
    SumOfGroupY=0;                                                          %and in SumOfGroupY there is the sum of x coordinate
    for j = 1:m
        if IDC(j,4) == i
            SumOfGroupX = SumOfGroupX+IDC(j,1);
            SumOfGroupY = SumOfGroupY+IDC(j,2);
            MembersOfGroup(i)=MembersOfGroup(i)+1;                         
        end
    end
    meanX=SumOfGroupX/MembersOfGroup(i);
    meanY=SumOfGroupY/MembersOfGroup(i);
    newClusterCenters(i,:)=[meanX, meanY];
end
FlagStopLoop = isequal(newClusterCenters,ClusterCenters);                   %If the coordinates of new and old cluster centers are the same the loop stops (FlagStopLoop==1)

if FlagStopLoop==0                                                          %If the loop don't stop, the programm will continue with the new cluster centers
    ClusterCenters=newClusterCenters;
    Continue = input('For update press Enter \n');   
end
CounterLoop=CounterLoop+1;

end

%{
%SSE calculation of each group
%}
SSEOfEachGroup=zeros(K,1);
for i = 1:K
    for j = 1:m
        if IDC(j,4) == i
            SSEOfEachGroup(i)=SSEOfEachGroup(i)+IDC(j,3);
        end
    end
end

%{
%In the end the algorithm prints the information of the clusters 
%}
sprintf('The program found the centers of each cluster after %d iterations',CounterLoop)
disp('The centers, the SSE, and the members of each cluster are:')
for i = 1:K
    sprintf('%d Cluster| Vectors=[%f,%f], SSE=%f, Members=%d \n', i, ClusterCenters(i,1), ClusterCenters(i,2), SSEOfEachGroup(i), MembersOfGroup(i))
end

disp('The total Sum of Squared Error is:')
disp(sum(SSEOfEachGroup));

end







