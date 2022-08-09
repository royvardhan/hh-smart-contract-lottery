module.exports = async function ({getNamedAccounts, deployments}) {
  const {deployer} = await getNamedAccounts();
  const {deployment} = deployments;
  const {raffle} = deployment;
  await raffle.setOwner(deployer, {from: deployer});
